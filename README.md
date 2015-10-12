# Reporting API Examples

The Reporting API provides easy and powerful access to a rich dataset on businesses, franchises, and their clients. Here are a few examples. 

For more details about request structures, reponse structures, column types, and more, see [Reporting API documentation](https://developer.frontdeskhq.com).

## Examples

### Invoice Items

See the [Invoice Item API documentation](https://developer.frontdeskhq.com/docs/reporting/v3#query-invoice-items) for available columns and groupings.

### Franchise revenue report

We will only report on the top ten revenue-generating franchises. As no timeframe is filtered this includes all sales ever recorded in Front Desk.

#### Request
```bash
curl -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
  { 
    "data": { 
      "type": "queries", 
      "attributes": { 
        "group": "business_name",
        "fields": ["total_net_paid_revenue_amount", "total_net_paid_amount", "total_net_paid_tax_amount" ],
        "sort": ["total_net_paid_revenue_amount-"],
        "page": { 
          "limit" : 10 
        }
      }
    }
  }
QUERY
```
#### Response
```bash
{
   "data":{
      "type":"queries",
      "attributes":{
         "rows":[
            [ "Reporting V3", 545315, 547542, 2227 ]
         ],
         "uuid":"df011dfa-9ab8-4263-b795-20ff812363fe",
         "duration":1.384004,
         "has_more":false,
         "fields":[
            {
               "name":"group_label",
               "type":"string"
            },
            {
               "name":"total_net_paid_revenue_amount",
               "type":"currency"
            },
            {
               "name":"total_net_paid_amount",
               "type":"currency"
            },
            {
               "name":"total_net_paid_tax_amount",
               "type":"currency"
            }
         ]
      }
   }
}
```

### Product sales activity report

We will only consider sales activity for a product named "Drop-In".

#### Request
```bash
curl -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
  { 
    "data": { 
      "type": "queries",       
      "attributes": { 
        "group": "closed_date",
        "filter": ["contains", "product_name", "Drop-In"],
        "fields": ["invoice_item_count", "total_net_paid_revenue_amount", "total_net_paid_amount", "total_net_paid_tax_amount" ], 
        "sort": ["total_net_paid_revenue_amount-"] 
      }
    }
  }
QUERY
```

#### Response
```bash
{
   "data":{
      "type":"queries",
      "attributes":{
         "rows":[
            [ "2015-09-02", 23, 11385, 11500, 115 ],
            [ "2015-09-03", 1, 500, 500, 0 ],
            [ "2015-09-01", 0, 0, 0, 0 ],
            [ "2015-09-05", 0, 0, 0, 0 ]            
         ],
         "uuid":"74dd4ff6-e9e9-49b3-9833-d8ef48b8394b",
         "duration":3.47039,
         "has_more":false,
         "fields":[
            {
               "name":"group_label",
               "type":"date"
            },
            {
               "name":"invoice_item_count",
               "type":"integer"
            },
            {
               "name":"total_net_paid_revenue_amount",
               "type":"currency"
            },
            {
               "name":"total_net_paid_amount",
               "type":"currency"
            },
            {
               "name":"total_net_paid_tax_amount",
               "type":"currency"
            }
         ]
      }
   }
}
```

### Most valuable clients report

We also happen to want to exclude retail and only consider the month of September, 2015.

#### Request
```bash
curl -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
  { 
    "data": { 
      "type": "queries",       
      "attributes": { 
        "group": "invoice_payer_name",
        "filter": [
        		"and", 
        		[
        			["ne", "product_type", "retail"],
        			["btw", "closed_date", ["2015-09-01", "2015-09-30"]]
        		]
        ],
        "fields": ["total_net_paid_revenue_amount" ], 
        "sort": ["total_net_paid_revenue_amount-"],
        "page": {
        	"limit" : 5
        } 
      }
    }
  }
QUERY
```

#### Response
```bash
{
   "data":{
      "type":"queries",
      "attributes":{
         "rows":[
            [ "Kaia Collins", 147088 ],
            [ "Jacquelyn Gleason", 130000 ],
            [ "Johnny Five", 90604 ],
            [ "Sydnee VonRueden", 83678 ],
            [ "Chadd Hane", 60000 ]
         ],
         "uuid":"3fb6009f-18bd-417c-9adc-9395f20ef51a",
         "duration":0.827071,
         "has_more":true,
         "fields":[
            {
               "name":"group_label",
               "type":"string"
            },
            {
               "name":"total_net_paid_revenue_amount",
               "type":"currency"
            }
         ]
      }
   }
}
```

### Recently sold items report

#### Request
```bash
curl -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
  { 
    "data": { 
      "type": "queries",       
      "attributes": { 
        "filter": ["eq", "invoice_state", "closed"],
        "fields": ["product_name", "product_type", "net_paid_revenue_amount", "invoice_payer_name"],
        "sort": ["closed_at-"],
        "page": {
        	"limit" : 5
        } 
      }
    }
  }
QUERY
```
#### Response
```bash
{
   "data":{
      "type":"queries",
      "attributes":{
         "rows":[
            [ "Reporting Monthly Plan", "monthly", 49505, "Sydnee VonRueden" ],
            [ null, "signup_fee", 1000, "Sydnee VonRueden" ],
            [ "Advanced Analytics", "pass", 9901, "Johnny Five" ],
            [ "SQL 101", "pass", 9901, "Sydnee VonRueden" ],
            [ "SQL 101", "pass", 9901, "Sydnee VonRueden" ]
         ],
         "uuid":"469bfad0-fd5e-4f66-a8e9-f65b71c53bd7",
         "duration":1.359252,
         "has_more":true,
         "fields":[
            {
               "name":"product_name",
               "type":"string"
            },
            {
               "name":"product_type",
               "type":"enum"
            },
            {
               "name":"net_paid_revenue_amount",
               "type":"currency"
            },
            {
               "name":"invoice_payer_name",
               "type":"string"
            }
         ]
      }
   }
}
```

### Best selling items report

#### Request
```bash
curl -D - -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/api/v3/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
  { 
    "data": { 
      "type": "queries",       
      "attributes": { 
      	"group": "product_name",
        "fields": ["invoice_item_count", "total_net_paid_revenue_amount"],
        "sort": ["invoice_item_count-"],
        "page": {
        	"limit" : 5
        } 
      }
    }
  }
QUERY

```

#### Response
```bash
{
   "data":{
      "type":"queries",
      "attributes":{
         "rows":[
            [ "Drop-in", 24, 11885 ],
            [ "Day Pass", 9, 85505 ],
            [ "Week Pass", 9, 69604 ],
            [ "Monthly Plan", 4, 99505 ],
            [ "One Year Prepaid", 3, 202970 ]
         ],
         "uuid":"9d1c61a7-34ee-46a1-85a1-9223a6d486fb",
         "duration":3.960124,
         "has_more":true,
         "fields":[
            {
               "name":"group_label",
               "type":"string"
            },
            {
               "name":"invoice_item_count",
               "type":"integer"
            },
            {
               "name":"total_net_paid_revenue_amount",
               "type":"currency"
            }
         ]
      }
   }
}
```

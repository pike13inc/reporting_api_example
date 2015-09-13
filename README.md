# Reporting API Examples

The Reporting API provides easy and powerful access to a rich dataset on businesses, franchises, and their clients. Here are a few examples. For full documentation on the Reporting API visit http://developer.frontdeskhq.com/docs/reporting/v3.

For more details about request structures, reponse structures, column types, and more, see [Reporting API documentation](https://developer.frontdeskhq.com).

## Obtaining an Auth Token without OAuth
Many application developers will obtain auth tokens by virtue of their users authenticating and authorizing the application via OAuth. If you do not plan on doing this (perhaps you're being contracted by a business to write a custom dashboard and simply want to begin making Reporting API queries) *and* you have a profile with the business with the necessary permission level, you many customize the following script and easily obtain an auth token:

[Retrive Auth Token](https://github.com/frontdesk/reporting_api_example/blob/master/retrieve_auth_token.sh)

## Examples

### Revenue by franchise

#### Request
```bash
curl -D - -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
  { 
    "data": { 
      "type": "queries", 
      "attributes": { 
        "page": { 
          "limit" : 10 
        }, 
        "group": "business_name",
        "fields": ["total_net_paid_revenue_amount", "total_net_paid_amount", "total_net_paid_tax_amount" ],
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
            [
               "Reporting V3",
               545315,
               547542,
               2227
            ]
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

### Sales activity of "Drop-In" by date

#### Request
```bash
curl -D - -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
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
            [
               "2015-09-02",
               23,
               11385,
               11500,
               115
            ],
            [
               "2015-09-03",
               1,
               500,
               500,
               0
            ],,
            [
               "2015-09-04",
               0,
               0,
               0,
               0
            ]            
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

### Top 5 revenue-generating clients for September, excluding retail sales

#### Request
```bash
curl -D - -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=<AUTH_TOKEN> -d @- <<QUERY
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
            [
               "Kaia Collins",
               147088
            ],
            [
               "Jacquelyn Gleason",
               130000
            ],
            [
               "Johnny Five",
               90604
            ],
            [
               "Sydnee VonRueden",
               83678
            ],
            [
               "Chadd Hane",
               60000
            ]
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

### Last 10 product sold

#### Request
```bash
curl -D - -H 'Content-Type:application/vnd.api+json' http://<SUBDOMAIN>.frontdeskhq.com/desk/api/v3/reports/invoice_items/queries?access_token=HbedjPspsJeTAlujXX2qI70uzm0BuKSZMMEpqcJU -d @- <<QUERY
  { 
    "data": { 
      "type": "queries",       
      "attributes": { 
        "filter": ["eq", "invoice_state", "closed"],
        "fields": ["product_name", "product_type", "net_paid_revenue_amount", "invoice_payer_name"],
        "sort": ["closed_at-"],
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
            [
               "Reporting Monthly Plan",
               "monthly",
               49505,
               "Sydnee VonRueden"
            ],
            [
               null,
               "signup_fee",
               1000,
               "Sydnee VonRueden"
            ],
            [
               "Advanced Analytics",
               "pass",
               9901,
               "Johnny Five"
            ],
            [
               "SQL 101",
               "pass",
               9901,
               "Sydnee VonRueden"
            ],
            [
               "SQL 101",
               "pass",
               9901,
               "Sydnee VonRueden"
            ],
            [
               "SQL 101",
               "pass",
               9901,
               "Sydnee VonRueden"
            ],
            [
               "Advanced Analytics",
               "pass",
               29703,
               "Tom Walker"
            ],
            [
               "Reporting pass",
               "pass",
               9901,
               "Johnny Five"
            ],
            [
               "Reporting pass",
               "pass",
               9901,
               "Johnny Five"
            ],
            [
               "Reporting pass",
               "pass",
               9901,
               "Johnny Five"
            ]
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

### top 5 revenue generating items

In the spirit of https://github.com/frontdesk/booking_platform_integration_example

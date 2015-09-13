# Reporting API Examples

The Reporting API provides easy and powerful access to a rich dataset on businesses, franchises, and their clients. Here are a few examples. For full documentation on the Reporting API visit http://developer.frontdeskhq.com/docs/reporting/v3.

For more details about request structures, reponse structures, column types, and more, see [Reporting API documentation](https://developer.frontdeskhq.com).

## Obtaining an Auth Token without OAuth
Many application developers will obtain auth tokens by virtue of their users authenticating and authorizing the application via OAuth. If you do not plan on doing this (perhaps you're being contracted by a business to write a custom dashboard and simply want to begin making Reporting API queries) *and* you have a profile with the business with the necessary permission level, you many customize the following script and easily obtain an auth token:

[Retrive Auth Token](https://github.com/frontdesk/reporting_api_example/blob/master/retrieve_auth_token.sh)

## Examples

### Revenue by franchise

Order all franchises by their total revenue. Also includes total payments, refunds, and discounts.

#### Request
```
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
```
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json
Date: Sun, 13 Sep 2015 04:49:57 GMT
Connection: close

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

### Revenue by quarters

### Top 5 spenders

### Top 5 selling items

### top 5 revenue generating items

In the spirit of https://github.com/frontdesk/booking_platform_integration_example

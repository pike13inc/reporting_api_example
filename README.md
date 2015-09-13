# Reporting API Examples
The Reporting API provides easy and powerful access to a rich dataset on businesses, franchises, and their clients. Here are a few examples. For full documentation on the Reporting API visit http://developer.frontdeskhq.com/docs/reporting/v3.

## Obtaining an Auth Token without OAuth
Many application developers will obtain auth tokens by virtue of their users authenticating and authorizing the application via OAuth. If you do not plan on doing this (perhaps you're being contracted by a business to write a custom dashboard and simply want to begin making Reporting API queries) *and* you have a profile with the business with the necessary permission level, you many customize the following script and easily obtain an auth token:

https://github.com/frontdesk/reporting_api_example/blob/master/retrieve_auth_token.sh

## Examples

### Cash flow by franchise

The following 

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
        "fields": ["total_net_paid_revenue_amount", "total_net_paid_amount", "total_refunds_amount", "total_discounts_amount" ], 
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
      "id":"7eeb2a5b-8bf0-4c8c-b1cf-521e298ff5cc",
      "attributes":{
         "rows":[
            [
               "Albuquerque",
               545315,
               547542,
               -55900,
               -23000
            ]            
         ],
         "duration":3.47818,
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
               "name":"total_refunds_amount",
               "type":"currency"
            },
            {
               "name":"total_discounts_amount",
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

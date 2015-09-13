# Reporting API Examples
The Reporting API provides easy and powerful access to a rich dataset on businesses, franchises, and their clients. Here are a few examples. For full documentation on the Reporting API visit http://developer.frontdeskhq.com/docs/reporting/v3.

## Obtaining an Auth Token without OAuth
Many application developers will obtain auth tokens by virtue of their users authenticating and authorizing the application via OAuth. If you do not plan on doing this (perhaps you're being contracted by a business to write a custom dashboard and simply want to begin making Reporting API queries) *and* you have a profile with the business with the necessary permission level, you many customize the following script and easily obtain an auth token:

https://github.com/frontdesk/reporting_api_example/blob/master/retrieve_auth_token.sh

## Examples

### Holding company summary (grouping by franchise)

```
curl -D - -H 'Content-Type:application/vnd.api+json' http://reportingv3.reporting-api.dev/api/v3/invoice_items/queries?access_token=HbedjPspsJeTAlujXX2qI70uzm0BuKSZMMEpqcJU -d @- <<QUERY
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

### Revenue by quarters

### Top 5 spenders

### Top 5 selling items

### top 5 revenue generating items

In the spirit of https://github.com/frontdesk/booking_platform_integration_example

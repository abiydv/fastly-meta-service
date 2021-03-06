# **Fastly Geo Service**

Implement a simple service that returns your public ip, geo-location etc. The data stays completely within your environment/Fastly service and there is no risk of attracting any unwanted attention if you use any of the many freely available services.

The response can be easily modified to suit any use-case.

Previous post: https://abiydv.github.io/posts/fastly-meta-service/

Geo Service post: https://abiydv.github.io/posts/fastly-geo-service/


## **REQUIRMENTS**

* Sign-up for a *limited* free Fastly account
* Terraform 12 or above

## **DEPLOY**

1. Export `FASTLY_API_KEY`
   ```
   $ export FASTLY_API_KEY=aabbccdd_01234
   ````

1. Initialize `terraform` and check plan
   ```
   $ terraform init
   $ terraform plan
   ````

1. Apply plan, type `yes` when prompted, to create the Fastly service
   ```
   $ terraform apply

   Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

   Outputs:

   service_domain = meta.dane-example.com
   shared_service_domain = meta.dane-example.com.global.prod.fastly.net

   ````

## **TEST**

Once the service is deployed, give it a minute or so, and then test using the `shared_service_domain`.

1. Check your own IP details
   ```
   $ curl -k https://meta.dane-example.com.global.prod.fastly.net/
   {
      "date": "Fri, 05 Mar 2021 16:23:53 GMT",
      "ipv6": "false",
      "public_ip": "34.66.60.237",
      "de_city": "HUISSEN",
      "de_country": "NL",
      "de_continent": "EU",
      "de_proxy" : "HOSTING - VPN",
      "mx_city": "COUNCIL BLUFFS",
      "mx_country": "US",
      "mx_continent": "NA"
   }
   ```

1. Check explicitly for an IP -
   ```
   $ curl -k https://meta.dane-example.com.global.prod.fastly.net/?ip=8.8.8.8 
   {
      "date": "Fri, 05 Mar 2021 16:23:53 GMT",
      "ipv6": "false",
      "public_ip": "8.8.8.8",
      "de_city": "MOUNTAIN VIEW",
      "de_country": "US",
      "de_continent": "NA",
      "de_proxy" : "ANONYMOUS - ?",
      "mx_city": "NEW YORK",
      "mx_country": "US",
      "mx_continent": "NA"
   }
   ```

1. Combine with `jq` to get specific details
   ```
   $ curl -k https://meta.dane-example.com.global.prod.fastly.net/ -s | jq -r .public_ip
   34.66.60.237
   ```


## **CLEANUP**

1. Export `FASTLY_API_KEY`
   ```
   $ export FASTLY_API_KEY=aabbccdd_01234
   ````

2. Delete the Fastly service
   ```
   $ terraform destroy

   Destroy complete! Resources: 2 destroyed.
   ````

## **NOTE** ##
This is a test/proof-of-concept. There are some configs to make it quick, which should be removed before actual implementation.

1. Update the domain - use a domain you own
2. Add appropriate CNAME entries to map the traffic to Fastly
3. Add a cert (either Fastly managed or self managed) to the HTTPS console on Fastly


# **Fastly Meta Service**

Implement a simple service that returns your public ip, geo-location etc. The data stays completely within your environment/Fastly service and there is no risk of attracting any unwanted attention if you use many freely available such services.

The response can be easily modified to suit any use-case.


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

1. Basic output
   ```
   $ curl http://meta.dane-example.com.global.prod.fastly.net
   Public IP: 192.168.1.1
   ```
1. Detailed output
   ```
   $ curl http://meta.dane-example.com.global.prod.fastly.net/more
   Public IP: 192.168.1.1 | City: LONDON | Country: GB | FServer: cache-xyz123 | FDC: LHR
   ```

   ** Have masked the real outputs above.

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


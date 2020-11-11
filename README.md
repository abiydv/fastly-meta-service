# **Fastly Meta Service**

Implement a simple service that returns your public ip, geo-location etc. The data stays completely within your environment/Fastly service and there is no risk of attracting any unwanted attention if you use many freely available such services.

The response can be easily modified to suit any use-case.


## **REQUIRMENTS**

* Sign-up for a *limited* free Fastly account
* Terraform 12 or above

## **DEPLOY**

1. Export `FASTLY_API_KEY`
   ```
   export FASTLY_API_KEY=aabbccdd_01234
   ````

1. Initialize `terraform` and check plan
   ```
   terraform init
   terraform plan
   ````

1. Apply plan to create the Fastly service
   ```
   terraform apply

   $ Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
   ````

## **TEST**

Hit the Fastly service on the shared domain to see the output

```
curl http://xyz.

```

## **CLEANUP**

1. Export `FASTLY_API_KEY`
   ```
   export FASTLY_API_KEY=aabbccdd_01234
   ````

2. Delete the Fastly service
   ```
   terraform destroy

   $ Apply complete! Resources: 0 added, 0 changed, 3 destroyed.
   ````



## **NOTE** ##
This is a test/proof-of-concept. There are some configs to make it quick, which should be removed before actual implementation.

1. Adding the Fastly shared domain fastly-bdd-example.com.global.prod.fastly.net in [feature files](tests/featues).


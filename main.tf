locals {
  domain = "example.com"
}


resource "random_pet" "domain" {
  length = 1
  keepers = {
    domain = local.domain
  }
}


resource "fastly_service_v1" "meta" {
  name = "meta"

  domain {
    name = format("meta.%s-%s", random_pet.domain.id, local.domain)
  }

  backend {
    name    = "httpbin.org"
    address = "httpbin.org"
    port    = 443
  }

  dynamic "snippet" {
    for_each = [for s in ["recv", "error"] : { name = s }]
    content {
      name    = snippet.value.name
      type    = snippet.value.name
      content = file("${path.module}/vcl/${snippet.value.name}.vcl")
    }
  }

  force_destroy = true
}


output "service_domain" {
  value = tolist(fastly_service_v1.meta.domain)[0].name
}

output "shared_service_domain" {
  value = format("%s.global.prod.fastly.net", tolist(fastly_service_v1.meta.domain)[0].name)
}


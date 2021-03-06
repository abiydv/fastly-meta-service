if (!req.url.path ~ "^/$" || !req.http.Fastly-SSL){
  error 618;
}

set req.url = querystring.filter_except(req.url, "ip");

if (fastly.ff.visits_this_service == 0 && req.restarts == 0) {
  set req.http.Fastly-Client-IP = client.ip;
  set req.http.ipv6 = "false";
  if (req.is_ipv6){
    set req.http.ipv6 = "true";
  }
}

if (req.url.qs ~ "ip"){
  set req.http.Fastly-Client-IP = querystring.get(req.url, "ip");
  set client.geo.ip_override = req.http.Fastly-Client-IP;
  set geoip.ip_override = req.http.Fastly-Client-IP;
}

error 620;

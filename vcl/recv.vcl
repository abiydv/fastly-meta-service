unset req.http.Cookie;

if (req.url ~ "^/$" ){
  set req.http.synthetic_resp = "Public IP: " + req.http.Fastly-Client-IP;
  error 620;
}

if (req.url ~ "^/more$" ){
  set req.http.synthetic_resp = "Public IP: " + req.http.Fastly-Client-IP + " | City: " + std.toupper(client.geo.city) + " | Country: " + client.geo.country_code + " | User-Agent: " + req.http.user-agent + " | FServer: " + server.hostname + " | FDC: " + server.datacenter;
  error 620;
}

if (req.url ~ "^/ip$" ){
  set req.http.synthetic_resp = req.http.Fastly-Client-IP;
  error 620;
}

set req.http.synthetic_resp = "Not Found!";
error 644;

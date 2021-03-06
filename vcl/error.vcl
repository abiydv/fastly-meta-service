if (obj.status == 618) {
    set obj.status = 301;
    set obj.response = "Moved Permanently";
    set obj.http.Location = "https://" req.http.host "/";
    set obj.http.cache-control = "private, no-store, no-cache, max-age=0";
    return (deliver);
}

if (obj.status == 620) {
    set obj.status = 200;
    set obj.response = "OK";
    set obj.http.Content-Type = "application/json";
    set obj.http.cache-control = "private, no-store, no-cache, max-age=0";
    synthetic 
{"{
    "date": ""} now {"",
    "ipv6": ""} req.http.ipv6 {"",
    "public_ip": ""} req.http.Fastly-Client-IP {"",
    "de_city": ""} client.geo.city {"",
    "de_country": ""} client.geo.country_code {"",
    "de_continent": ""} client.geo.continent_code {"",
    "de_proxy" : ""} client.geo.proxy_type  " - " client.geo.proxy_description {"",
    "mx_city": ""} geoip.city {"",
    "mx_country": ""} geoip.country_code {"",
    "mx_continent": ""} geoip.continent_code {""
}"};
    return (deliver);
}

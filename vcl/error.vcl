if (obj.status == 620) {
    set obj.status = 200;
    set obj.response = "OK";
    set obj.http.Content-Type = "text/html";
    set obj.http.cache-control = "private, no-store, no-cache, max-age=0";
    synthetic req.http.synthetic_resp;
    return (deliver);
}

if (obj.status == 644) {
    set obj.status = 404;
    set obj.response = "Not Found";
    set obj.http.Content-Type = "text/html";
    set obj.http.cache-control = "private, no-store, no-cache, max-age=0";
    synthetic req.http.synthetic_resp;
    return (deliver);
}

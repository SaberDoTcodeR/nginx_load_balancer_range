# Nginx Range Load Balancer

A `Lua` script to distribute `GET` requests among 3 servers with respect to `Range` header of `GET` request.

- Set `content_length` variable to length of content (You can also set it to `ngx.req.get_headers()["Content-Length"]`).
- Set `second_server` and `third_server` variables to other server addresses.
- First server will be current server that Nginx is runnig on.
- Multirange `GET` requests are supported.

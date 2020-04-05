# Nginx Range Load Balancer

A `Lua` script to distribute get requests among 3 servers with respect to range header og `GET` request.

- Set `content_length` variable to length of content.
- Set `second_server` and `third_server` variables to other server addresses.
- First server will be current server that Nginx is runnig on.
- Multirange `GET` requests are supported.

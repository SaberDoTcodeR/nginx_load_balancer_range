
content_length = 90000000
second_server = "https://server2.com"
third_server = "https://server3.com"

function get_redirect_url(server)
    return server .. ngx.var.uri
end

function parse_range(range)
    local matches, err = ngx.re.match(range, "^bytes=(\\\\d+)?-(\\\\d+)?(\\\\s*,\\\\s*(\\\\d+)?-(\\\\d+)?)*$", "joi")

    if matches then
        if matches[1] == nil and matches[2] then
            return content_length - matches[2], content_length - 1
        end
        return matches[1] or 0, matches[2] or (content_length - 1)
    end
    return 0, content_length - 1
end

function do_request(start, stop)
    if start > content_length / 3 and stop <= content_length * 2 / 3 then
        ngx.redirect(get_redirect_url(second_server))
    elseif start > content_length * 2 / 3 then
        ngx.redirect(get_redirect_url(third_server))
    end
end

local range_header = ngx.req.get_headers()["Range"] or "bytes=0-"
local start, stop = parse_range(range_header)
do_request(tonumber(start),tonumber(stop))

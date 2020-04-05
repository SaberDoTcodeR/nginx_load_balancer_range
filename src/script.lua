content_length = 1000000

function parse_range(range)
    local matches, err = ngx.re.match(range, "^bytes=(\\\\d+)?-(\\\\d+)?$", "joi")

    if matches then
        if matches[1] == nil and matches[2] then
            return content_length - matches[2], content_length - 1
        end
        return matches[1] or 0, matches[2] or (content_length - 1)
    end
    return 0, content_length - 1
end
function do_request(start, stop)
    if stop < content_length / 3 then
        return 0
    elseif start >= content_length / 3 and stop < content_length * 2 / 3 then
        ngx.redirect("https://google.com", 302)
    elseif start >= content_length * 2 / 3 then
        ngx.redirect("https://varzesh3.com", 302)
    end
end

local range_header = ngx.req.get_headers()["Range"] or "bytes=0-"
local start, stop = parse_range(range_header)
do_request(tonumber(start),tonumber(stop))
-- parse range header
local range_header = ngx.req.get_headers()["Range"] or "bytes=0-"
local matches, err = match(range_header, "^bytes=(\\d+)?-([^\\\\]\\d+)?", "joi")
if matches then
	if matches[1] == nil and matches[2] then
		stop = (origin_headers["Content-Length"] - 1)
		start = (stop - matches[2]) + 1
	else
		start = matches[1] or 0
		stop = matches[2] or (origin_headers["Content-Length"] - 1)
	end
else
	stop = (origin_headers["Content-Length"] - 1)
end

ngx.say(start)
ngx.say(stop)
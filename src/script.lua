local match = ngx.re.match

            	local start = 0
local stop = -1
content_length = 1000000

-- parse range header
local range_header = ngx.req.get_headers()["Range"] or "bytes=0-"
local matches, err = match(range_header, "^bytes=(\\\\d+)?-(\\\\d+)?", "joi")
if matches then
	if matches[1] == nil and matches[2] then
		stop = (content_length - 1)
		start = (stop - matches[2]) + 1
	else
		start = matches[1] or 0
		stop = matches[2] or (content_length - 1)
	end
else
	stop = (content_length - 1)
end

ngx.say(start)
ngx.say(stop)


function get_server_index(start, stop)
    if stop < content_length / 3 then
        return 0
    elseif start >= content_length / 3 and stop < content_length * 2 / 3 then
        return 1
    elseif start >= content_length * 2 / 3 then
        return 2
    end
end

ngx.say(get_server_index(0,34566))
ngx.say("bye")
		
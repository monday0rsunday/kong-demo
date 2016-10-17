local sing = require "kong.singletons"
local BasePlugin = require "kong.plugins.base_plugin"

local HelloWorldhandler = BasePlugin:extend()


function HelloWorldhandler:new()
	HelloWorldhandler.super.new(self, "lua-test")
end

function HelloWorldhandler:access(conf)
	HelloWorldhandler.super.access(self)
	ngx.header["Println"] = "Hello World"
	ngx.header["custom_id"] = conf.custom_id
	-- return responses.send_HTTP_FORBIDDEN("Hello NAL")
end

function HelloWorldhandler:head_filter(conf)
	HelloWorldhandler.super.head_filter(self)
end

function HelloWorldhandler:body_filter(conf)
	HelloWorldhandler.super.body_filter(self)
	local chunk, eof = ngx.arg[1], ngx.arg[2]
	if eof then
		-- ngx.header.content_type="text/plain"
		ngx.arg[1] = "Hello NAL"
	else
		ngx.arg[1] = nil
	end
end

return HelloWorldhandler
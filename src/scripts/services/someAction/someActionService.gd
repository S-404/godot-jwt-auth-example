extends AwaitableHTTPRequest

func doSmth() -> Dictionary:
	return await BaseApi.fetch(BaseQueryType.new(
		"/action/doSmth",
		HTTPClient.METHOD_POST,
		{},
		true
	))

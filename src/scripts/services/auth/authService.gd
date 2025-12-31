extends AwaitableHTTPRequest

func register(credentials: Dictionary) -> Dictionary:
	return await BaseApi.fetch(BaseQueryType.new(
		"/auth/register",
		HTTPClient.METHOD_POST,
		credentials
	))

func login(credentials: Dictionary) -> Dictionary:
	return await BaseApi.fetch(BaseQueryType.new(
		"/auth/login",
		HTTPClient.METHOD_POST,
		credentials
	))

func refresh() -> Dictionary:
	return await BaseApi.fetch(BaseQueryType.new(
		"/auth/refresh",
		HTTPClient.METHOD_POST,
		{},
		true,
	))
	
func logout() -> void:
	await BaseApi.fetch(BaseQueryType.new(
		"/auth/logout",
		HTTPClient.METHOD_POST,
		{},
		true,
		true,
	))

	TokenEvent.invalidate_tokens()

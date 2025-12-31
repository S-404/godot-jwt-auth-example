extends AwaitableHTTPRequest

const SERVER_URL = "http://localhost:8082/api"
const AUTH_ERROR_CODES = [401]

func fetch(query: BaseQueryType) -> Dictionary:
	var response = await _baseQueryWithReAuth(query)
	
	if(!query.ignore_errors):
		ApiExceptionHandler.handle(response)
	
	var result = {
		"data": response.body_as_json() if response.status and response.bytes else {},
		"is_status_ok": response.status_ok(),
		"is_success": response.success(),
	}

	print("fetch result", result)

	return result

func _baseQueryWithReAuth(query: BaseQueryType) -> HTTPResult:
	var response = await _baseQuery(query)

	if AUTH_ERROR_CODES.has(response.status):
		var refresh_response = await _refresh()
		if refresh_response.status_ok():
			response = await _baseQuery(query)
		else:
			TokenEvent.invalidate_tokens()

	return response
	

func _baseQuery(query: BaseQueryType) -> HTTPResult:
	var headers := []
	var payload := ""

	if query.with_credentials:
		headers.push_back("Cookie: " + CookieJar.cookies_to_string())

	if query.data.keys().size():
		headers.push_back("Content-Type: application/json")
		payload = JSON.stringify(query.data)

	var token = Storage.get_key_value("token")
	if token:
		headers.push_back(
			"Authorization: Bearer {token}".format({
				"token": Storage.get_key_value("token")
			})
		)

	var response := await async_request(
		SERVER_URL + query.endpoint,
		headers,
		query.method,
		payload,
	)

	if response.success() and response.status_ok():
		CookieJar.save_cookies(response.cookies)
	
	return response

func _refresh() -> HTTPResult:
	var response = await _baseQuery(BaseQueryType.new(
		"/auth/refresh",
		HTTPClient.Method.METHOD_POST,
		{},
		true,
	))

	if response.success() and response.status_ok():
		var data = response.body_as_json()
		Storage.set_key_value("token", data.accessToken)

	return response

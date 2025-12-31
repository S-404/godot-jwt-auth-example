extends Node

func log_erorr(message: String):
	print("API EXCEPTION: " + message)

func handle(response: HTTPResult)->void:
	if response.status_ok(): return
	if(!response.status):
		log_erorr("no connection with server")
		return

	if(response.status == 404):
		log_erorr("invalid request path")
		return

	var body = response.body_as_json()
	var code = body.get("code")

	match code:
		"ERR_APP":
			log_erorr("internal server error")
		"ERR_CLIENT_REQUEST_VALIDATION":
			log_erorr("request validation")
		"ERR_CLIENT_AUTH":
			log_erorr("authorization error")
		"ERR_CLIENT_ENTITY_ALREADY_EXIST":
			log_erorr("already exists")
		"ERR_CLIENT_ENTITY_NOT_FOUND":
			log_erorr("not found")
		"ERR_CLIENT_BAD_REQUEST":
			log_erorr("bad request")
		_:
			log_erorr("unknown error")

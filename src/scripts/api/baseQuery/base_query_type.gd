class_name BaseQueryType

var endpoint: String
var method: int 
var data: Dictionary
var with_credentials: bool
var ignore_errors: bool

func _init(
	endpoint_ : String,
	method_ := HTTPClient.Method.METHOD_GET,
	data_ := {},
	with_credentials_ := false,
	ignore_errors_ := false,
):
	endpoint = endpoint_
	method = method_
	data = data_
	with_credentials = with_credentials_
	ignore_errors = ignore_errors_

	

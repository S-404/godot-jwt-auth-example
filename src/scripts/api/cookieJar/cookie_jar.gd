extends Node

const COOKIES_KEY = "cookies"
var _dict: Dictionary = {}

func save_cookies(cookie_dict) -> void:
	_dict = cookie_dict
	Storage.set_key_value(COOKIES_KEY, _dict)

func clear_all() -> void:
	save_cookies({})

func cookies_to_string() -> String:
	return "; ".join(list_cookie_values())

func list_cookie_values() -> Array:
	var arr := []
	for key in _dict.keys():
		var value = _dict.get(key).split(";")[0]
		arr.push_back(value)
	return arr

func _init():
	var saved_cookies = Storage.get_key_value(COOKIES_KEY)
	_dict = saved_cookies if saved_cookies else {}

extends Node

signal is_auth_checked_signal(value: bool)
var is_authed = false

func checkIsAuthed():
	if(CookieJar.list_cookie_values().size() > 0):
		var res = await AuthService.refresh()
		is_authed = !!res.get("is_status_ok")
		is_auth_checked_signal.emit(is_authed)

func set_is_authed(value:bool)->void:
	is_authed = value
	is_auth_checked_signal.emit(is_authed)

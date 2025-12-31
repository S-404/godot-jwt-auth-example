extends Node

func invalidate_tokens()->void:
	CookieJar.clear_all()
	Storage.delete_key("token")
	AuthStore.set_is_authed(false)

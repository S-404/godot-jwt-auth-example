extends Node2D

var username = ""
var password = ""

func _ready():
	AuthStore.is_auth_checked_signal.connect(_is_auth_checked_signal_received)
	AuthStore.checkIsAuthed()

func _is_auth_checked_signal_received(is_authed: bool):
	if(is_authed):
		print("IAM AUTHED")
		SceneEvent.change_scene(SceneEvent.Scene_name.LOBBY)

func _on_username_input_text_changed(new_text):
	username = new_text


func _on_password_input_text_changed(new_text):
	password = new_text


func _on_test_btn_pressed():
	AuthService.refresh()


func _on_sign_in_button_pressed() -> void:
	var res = await AuthService.login({
		"username": username, 
		"password": password
	})

	AuthStore.set_is_authed(res.get("is_status_ok"))


func _on_sign_up_button_pressed() -> void:
	var res = await AuthService.register({
		"username": username, 
		"password": password
	})
	AuthStore.set_is_authed(res.get("is_status_ok"))

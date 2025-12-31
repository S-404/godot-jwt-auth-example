extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("WELCOME")


func _on_logout_button_pressed() -> void:
	await AuthService.logout()
	SceneEvent.change_scene(SceneEvent.Scene_name.LOGIN)

func _on_authed_action_button_pressed() -> void:
	await SomeActionService.doSmth()

func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

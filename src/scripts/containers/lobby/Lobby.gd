extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("WELCOME")


func _on_button_pressed():
	await AuthService.logout()
	SceneEvent.change_scene(SceneEvent.Scene_name.LOGIN)


func _on_button_2_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_button_3_pressed() -> void:
	print("did smth")


func _on_button_4_pressed() -> void:
	print("did smth else")


func _on_button_5_pressed() -> void:
	pass # Replace with function body.

extends Node

enum Scene_name {
	LOBBY,
	LOGIN,
}

const scene_path := {
	Scene_name.LOBBY: "res://src/containers/Lobby.tscn",
	Scene_name.LOGIN: "res://src/containers/Login.tscn",
}

func change_scene(scene: Scene_name):
	get_tree().change_scene_to_file(scene_path.get(scene))
	

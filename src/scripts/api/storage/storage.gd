extends Node

const _STORAGE_FILE_PATH = "user://storage.save"
var _dict: Dictionary = {}

func get_key_value(key: String) -> Variant:
	return _dict.get(key)

func set_key_value(key: String, value: Variant) -> void:
	_dict[key] = value
	_save_dict()

func delete_key(key: String) -> void:
	_dict.erase(key)
	_save_dict()

func _init():
	if FileAccess.file_exists(_STORAGE_FILE_PATH):
		_load_storage_file()
	else:
		_save_dict()

func _save_dict() -> void:
	var storage_file = FileAccess.open(_STORAGE_FILE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(_dict)
	storage_file.store_line(json_string)

func _load_storage_file() -> void:
	var storage_file = FileAccess.open(_STORAGE_FILE_PATH, FileAccess.READ)
	var json_string = storage_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)

	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return

	_dict = json.data

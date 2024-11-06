extends Node


var data = {}


@export var pick_up: int = 0
@export var drop: int = 0
@export var succ_submit: int = 0
@export var fai_submit: int = 0
@export var clear: int = 0
@export var crouch: int = 0
@export var shutter: int = 0
@export var pause: int = 0


func save_data():
	var log_file = "user://" + Time.get_date_string_from_system() + ".json"
	var file = FileAccess.open(log_file, FileAccess.WRITE)
	print(log_file)
	data = {
		"pick_up" = pick_up,
		"drop" = drop,
		"succ_submit" = succ_submit,
		"fai_submit" = fai_submit,
		"clear" = clear,
		"crouch" = crouch,
		"shutter" = shutter,
		"pause" = pause,
	}
	file.store_var(data)
	file = null

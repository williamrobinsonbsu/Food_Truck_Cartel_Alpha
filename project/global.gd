extends Node


var data
var data_array: Array = ["Pickups", "Drops", "Successful Submissions", "Failed Submissions", "Plate Clears", "Crouches", "Shutters", "Pauses"]
var index := 0


@export var pick_up: int = 0
@export var drop: int = 0
@export var succ_submit: int = 0
@export var fai_submit: int = 0
@export var clear: int = 0
@export var crouch: int = 0
@export var shutter: int = 0
@export var pause: int = 0


func save_data():
	var log_file = "user://" + Time.get_date_string_from_system() + ".csv"
	var file = FileAccess.open(log_file, FileAccess.WRITE)
	var numeric_data = [pick_up, drop, succ_submit, fai_submit, clear, crouch, shutter, pause]
	print(log_file)
	
	
	while index < 8:
		data = PackedStringArray([data_array[index], str(numeric_data[index])])
		file.store_csv_line(data)
		index += 1
	file = null

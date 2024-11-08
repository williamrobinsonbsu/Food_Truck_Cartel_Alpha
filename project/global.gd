extends Node



@export var end_of_level_money: int = 0


var data
var data_array: Array = [
		"Pickups", 
		"Drops", 
		"Successful Submissions", 
		"Failed Submissions", 
		"Plate Clears", 
		"Crouches", 
		"Shutters", 
		"Pauses",
		"Grill Uses",
		"Frier Uses",
		"Cut Board Uses"
		]
var index := 0

 


@export var pick_up: int = 0
@export var drop: int = 0
@export var succ_submit: int = 0
@export var fai_submit: int = 0
@export var clear: int = 0
@export var crouch: int = 0
@export var shutter: int = 0
@export var pause: int = 0
@export var grill_used: int = 0
@export var frier_used: int = 0
@export var cut_board_used: int = 0


func save_data():
	var time = Time.get_time_dict_from_system()
	var curr_time = "%02d-%02d-%02d" % [time.hour, time.minute, time.second]
	
	var log_file = "user://PLAYTEST-" + Time.get_date_string_from_system() + "-" + curr_time + ".csv"
	var file = FileAccess.open(log_file, FileAccess.WRITE)
	var numeric_data = [pick_up, drop, succ_submit, fai_submit, clear, crouch, shutter, pause, grill_used, frier_used, cut_board_used]
	print(log_file)
	
	
	while index < data_array.size():
		data = PackedStringArray([data_array[index], str(numeric_data[index])])
		file.store_csv_line(data)
		index += 1
	file = null

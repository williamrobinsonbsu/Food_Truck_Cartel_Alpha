extends Node


const SAVE_FILE := "user://savefile.dat"

var level_rave := 0
var level_casino := 0
var level_area51 := 0
var level_endless := 0
var level_data = { }

var prev_npc = -1

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
		"Cut Board Uses",
		"Police Spawns",
		"Caught by Police",
		"Police Dodges",
		"Level Quit",
		"Ending Money"
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
@export var police_spawns: int = 0
@export var police_catches: int = 0
@export var police_dodges: int = 0
@export var level_quit: int = 0
@export var curr_level: String = "no_level"


func save_data():
	var time = Time.get_time_dict_from_system()
	var curr_time = "%02d-%02d-%02d" % [time.hour, time.minute, time.second]
	
	var log_file = "user://" + curr_level + "-PLAYTEST-" + Time.get_date_string_from_system() + "-" + curr_time + ".csv"
	var file = FileAccess.open(log_file, FileAccess.WRITE)
	var numeric_data = get_num_array()
	print(log_file)
	
	data = PackedStringArray(["Level", curr_level])
	file.store_csv_line(data)
	while index < data_array.size():
		data = PackedStringArray([data_array[index], str(numeric_data[index])])
		file.store_csv_line(data)
		index += 1
	file = null
	reset_data()
	index = 0
	

func get_num_array():
	return [
			pick_up, 
			drop,
			succ_submit, 
			fai_submit, 
			clear, 
			crouch, 
			shutter, 
			pause, 
			grill_used, 
			frier_used, 
			cut_board_used,
			police_spawns,
			police_catches,
			police_dodges,
			level_quit,
			end_of_level_money]

func reset_data():
	pick_up = 0
	drop = 0
	succ_submit = 0
	fai_submit = 0
	clear = 0
	crouch = 0
	shutter = 0
	pause = 0
	grill_used = 0
	frier_used = 0
	cut_board_used = 0
	police_spawns = 0
	police_catches = 0
	police_dodges = 0
	level_quit = 0
	
	
func save_unlocked_levels():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	level_data = {
		"level_rave" = level_rave,
		"level_casino" = level_casino,
		"level_area51" = level_area51,
		"level_endless" = level_endless
	}
	file.store_var(level_data)
	file = null
	

func load_unlocked_levels():
	if not FileAccess.file_exists(SAVE_FILE):
			level_data = {
							"level_rave" = 0,
							"level_casino" = 0,
							"level_area51" = 0,
							"level_endless" = 0
			}
			save_unlocked_levels()
	
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	level_data = file.get_var()
	level_rave = level_data.level_rave
	level_casino = level_data.level_casino
	level_area51 = level_data.level_area51
	level_endless = level_data.level_endless
	file = null

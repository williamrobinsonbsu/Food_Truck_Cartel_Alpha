extends Node3D


@export var score = 0
@export var starting_counter = 0
@export var level: String
@export var lane_progression_counter = 0
@export var diff_modifier: float
signal timer
var shutter_door_close = false
var can_police_catch_player = false
var poRate = 0
var goal_score = 150



@onready var customer_or_cop_timer: Timer = $customer_or_police_spawn_timer
@onready var cop_catch_timer: Timer = $cop_catch_timer


func _ready():
	level = str(get_parent().get_parent().name)
	print(level)
	get_node("/root/" + level + "/Kitchen/Player/Control/CatchMeter").value = 0
	var value = get_node("/root/" + level + "/Kitchen/Player/Control/CatchMeter").value
	print(value)
	
	if level == "Beach":
		diff_modifier = 1
	elif level == "RaveKitchen":
		diff_modifier = 1.25
	elif level == "Area51":
		diff_modifier = 1.5
	elif level == "Casino":
		diff_modifier = 1.75
	

func _physics_process(_delta: float) -> void:
	get_node("/root/" + level + "/Kitchen/Player/Control/CatchMeter").value = cop_catch_timer.get_time_left() * 20
	
	# QA INPUT CHEATS
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
	if Input.is_action_pressed("police_lane_1"):
		_spawn_police(1)
	
	if Input.is_action_pressed("police_lane_2"):
		_spawn_police(2)
	
	if Input.is_action_pressed("police_lane_3"):
		_spawn_police(3)
	
	if Input.is_action_pressed("give_money"):
		score += 100
		$register/score.text = str("$" + str(score))
	
	if Input.is_action_just_pressed("toggle_level_timer"):
		if $LevelTimer.paused == true:
			$LevelTimer.paused = false
		elif $LevelTimer.paused == false:
			$LevelTimer.paused = true
	
	if Input.is_action_just_pressed("toggle_order_timer"):
		get_tree().call_group("customer", "toggle_assembly_timer")
		
func shutter_door_control():
	if shutter_door_close == false:
		$ShutterDoor.hide()
		shutter_door_close = true
		door_shutter()
		if starting_counter == 0:
			_on_new_customer()
			get_node("/root/" + level + "/Kitchen/Player/Control/DayIcon").show()
			get_node("/root/" + level + "/Kitchen/Player/DayTimer").start()
			$LevelTimer.start()
			timer.emit()
			starting_counter += 1
		can_police_catch_player = true
	
	elif shutter_door_close == true:
		$ShutterDoor.show()
		shutter_door_close = false
		door_shutter()
		can_police_catch_player = false

func door_status():
	return shutter_door_close

func door_shutter():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://audio/shutter_open_close.wav")
	audio_stream_player.bus = "Sound"
	#audio_stream_player.volume_db = linear_to_db(.3)
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
		audio_stream_player.queue_free()
	)

func _spawn_new_customer_or_cop():
	customer_or_cop_timer.start()
	

func _on_customer_or_police_spawn_timer_timeout():
	_customer_or_cop()

func _customer_or_cop():
	_on_new_customer()
	starting_counter += 1
	poRate = policeRate()
	if poRate != 0:
		_on_police()
		print(poRate)
	

func _on_new_customer():
	#print("Your score is: ")
	#print(score)
	var scene = preload("res://customer/customer.tscn")
	var customer = scene.instantiate()
	customer.level = level
	customer.level_path = level.to_snake_case()
	print(customer.level_path)
	add_child(customer)
	customer.position = %customer.position
		
	
func _on_police():
	#var audio_stream_player := AudioStreamPlayer.new()
	#audio_stream_player.stream = load("res://audio/police_siren.wav")
	#audio_stream_player.volume_db = linear_to_db(0.3)
	#get_parent().add_child(audio_stream_player)
	#audio_stream_player.play()
	#audio_stream_player.finished.connect(func():
	#	audio_stream_player.queue_free()
	#)
	var scene = preload("res://police/police.tscn")
	var police = scene.instantiate()
	var i = 0
	add_child(police)
	if lane_progression_counter == 1:
		i = randi()%2
		police.scale = Vector3(0.1, 0.1, 0.1)
		if i == 0:
			police.position = $Far1.position
		elif i == 1:
			police.position = $Far2.position
		else:
			police.position = $Far3.position
			police.scale.x *= -1
	elif lane_progression_counter == 2:
		i = randi()%2
		police.scale = Vector3(0.5, 0.5, 0.5)
		if i == 0:
			police.position = $Mid1.position
		elif i == 1:
			police.position = $Mid2.position
		else:
			police.position = $Mid3.position
			police.scale.x *= -1
	else:
		i = randi()%1
		police.scale = Vector3(1, 1, 1)
		if i == 0:
			police.position = $Close1.position
		elif i == 1:
			police.position = $Close2.position
		police.catch()
		cop_catch_timer.start()
		

func policeRate():
	if randf() <= .3 * diff_modifier:
		if lane_progression_counter < 3:
			lane_progression_counter += 1
		else:
			lane_progression_counter = 0
	
	return lane_progression_counter
		
func _on_police_catch_timer_timeout():
	if can_police_catch_player == true:
		get_tree().change_scene_to_file("res://menus/caught_scene.tscn")
		
	elif can_police_catch_player == false:
		get_node("/root/" + level + "/Kitchen/Player/Control/CatchMeter").value = 0	
		get_tree().call_group("police", "despawn")


func _on_level_timer_timeout():
	#$"../Player/Control/LevelTimerLabel".text = "Final score: $" + str(score)
	print(score)
	#if score == goal_score or score > goal_score:
		#$"../Player/Control/LevelTimerLabel".text += """
		#Good Job!"""
	#elif score < goal_score:
		#$"../Player/Control/LevelTimerLabel".text += """
		#Uh oh..."""
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menus/result_screen.tscn")
	

func _spawn_police(modifier):
	if modifier < 1 or modifier > 3:
		pass
	else:
		cop_catch_timer.stop()
		get_tree().call_group("police", "despawn")
		lane_progression_counter = modifier
		_on_police()

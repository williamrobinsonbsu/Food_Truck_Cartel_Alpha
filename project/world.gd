extends Node3D

@onready var customer_or_cop_timer := $customer_or_police_spawn_timer
@onready var cop_catch_timer := $cop_catch_timer
@onready var order_time: Label = get_node("/root/World/Player/Control/OrderTimerLabel")

var shutter_door_close = false
var can_police_catch_player = false
@export var score = 0
@export var starting_counter = 0

@export var lane_progression_counter = 0
var poRate = 0
var goal_score = 150
var j := 60
signal timer

func _ready():
	get_node("/root/World/Player/Control/CatchMeter").value = 0	
	var value = get_node("/root/World/Player/Control/CatchMeter").value
	print(value)
	

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
func shutter_door_control():
	if shutter_door_close == false:
		$ShutterDoor.hide()
		shutter_door_close = true
		door_shutter()
		if starting_counter == 0:
			_on_new_customer()
			get_node("/root/World/Player/Control/DayIcon").show()
			get_node("/root/World/Player/DayTimer").start()
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
	audio_stream_player.volume_db = linear_to_db(.3)
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
	j = 0
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
	add_child(customer)
	customer.position = %customer.position
	
	j = 60
	order_time.text = str(j)
	while j != 0:
		j -= 1
		order_time.text = str(j)
		await get_tree().create_timer(1).timeout
		
	
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
	var j = 0
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
		while j < 10:
			#get_node("/root/World/Player/Control/CatchMeter").text += "-"
			get_node("/root/World/Player/Control/CatchMeter").value += 10
			await get_tree().create_timer(.5).timeout
			j += 1

func policeRate():
	if randf() <= .3:
		if lane_progression_counter < 3:
			lane_progression_counter += 1
		else:
			lane_progression_counter = 0
	
	return lane_progression_counter
		
func _on_police_catch_timer_timeout():
	if can_police_catch_player == true:
		get_tree().change_scene_to_file("res://menus/caught_scene.tscn")
		
	elif can_police_catch_player == false:
		get_node("/root/World/Player/Control/CatchMeter").value = 0	
		get_tree().call_group("police", "despawn")


func _on_level_timer_timeout():
	$"../Player/Control/LevelTimerLabel".text = "Final score: $" + str(score)
	print(score)
	if score == goal_score or score > goal_score:
		$"../Player/Control/LevelTimerLabel".text += """
		Good Job!"""
	elif score < goal_score:
		$"../Player/Control/LevelTimerLabel".text += """
		Uh oh..."""
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menus/caught_scene.tscn")
	

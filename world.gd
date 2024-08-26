extends Node3D

@onready var policeman := $police
@onready var customer_or_cop_timer := $customer_or_police_spawn_timer
@onready var cop_catch_timer := $police/police_catch_timer

var shutter_door_close = false
var can_police_catch_player = false
var score = 0
var starting_counter = 0

var laneProgressionCounter = 0
var poRate = 0
var spotSpawn = 0
var awareMeter = 0
var rng = RandomNumberGenerator.new()

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
	if starting_counter == 0:
		score += 0
	else:
		score += 10
	_on_new_customer()
	starting_counter += 1
	poRate = policeRate()
	if poRate != 0:
		_on_police()
		print(poRate)
	

func _on_new_customer():
	print("Your score is: ")
	print(score)
	get_node("/root/World/Player/Control/score").text = "Score: $" + str(score)
	get_node("/root/World/Root Scene/register/score").text = "$" + str(score)
	var scene = preload("res://customer/customer.tscn")
	var customer = scene.instantiate()
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
	if laneProgressionCounter == 1:
		i = rng.randf_range(1,3)
		if i == 1:
			police.position = $Far1.position
		elif i == 2:
			police.position = $Far2.position
		else:
			police.position = $Far3.position
	elif laneProgressionCounter == 2:
		i = rng.randf_range(1,3)
		police.position = $Mid1.position
	elif laneProgressionCounter == 3:
		i = rng.randf_range(1,2)
		police.position = $Close1.position
		cop_catch_timer.start()

func policeRate():
	#if randf() <= .3:
	if laneProgressionCounter < 3:
		laneProgressionCounter += 1
	return laneProgressionCounter
		
func _on_police_catch_timer_timeout():
	if can_police_catch_player == true:
		print('\nYou got caught')
		print("Your score is: ")
		print(score)
		$"../Player/Control/GameOver".show()
		await get_tree().create_timer(5.0).timeout
		get_tree().reload_current_scene()
		#get_tree().quit()
	elif can_police_catch_player == false:
		policeman.hide()
		_spawn_new_customer_or_cop()

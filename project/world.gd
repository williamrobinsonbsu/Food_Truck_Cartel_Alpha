extends Node3D


signal end_of_level
signal cop_present(gone: bool)

@export var score = 0
@export var starting_counter = 0
@export var level: String
@export var lane_progression_counter = 0
@export var diff_modifier: float
signal timer
var shutter_door_close = false
var can_police_catch_player = false
var poRate = 0
var goal_score = 50
var cop_present_bool = true

@onready var customer_or_cop_timer: Timer = $customer_or_police_spawn_timer
@onready var cop_catch_timer: Timer = $cop_catch_timer
@onready var level_timer: Timer = $LevelTimer
@onready var player: CharacterBody3D = $"../Player"
@onready var timer_sign: Node3D = $"../CustomerTimerSign"


func _ready():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	MenuMusic.stream_paused = true
	level = str(get_parent().get_parent().name)
	Global.curr_level = level
	print(level)
	if level == "Beach":
		diff_modifier = 1
		LevelMusic.stream = load("res://audio/music/beach-ambiance-16328.ogg")
		LevelMusic.play()
	elif level == "RaveKitchen":
		diff_modifier = 1.25
		LevelMusic.stream = load("res://audio/music/Raving Energy (faster).ogg")
		LevelMusic.play()
	elif level == "Area51":
		diff_modifier = 1.75
		LevelMusic.stream = load("res://audio/music/Voxel Revolution.ogg")
		LevelMusic.play()
	elif level == "Casino":
		diff_modifier = 1.5
		LevelMusic.stream = load("res://audio/music/Boogie Party.ogg")
		LevelMusic.pitch_scale = .9
		LevelMusic.play()
	elif level == "Endless":
		diff_modifier = 2.0
		LevelMusic.stream = load("res://audio/music/Boogie Party.ogg")
		LevelMusic.play()
		level_timer.paused = true
		#get_node("/root/" + level + "/Kitchen/Root Scene/hot_dog_box").show()
		#get_node("/root/" + level + "/Kitchen/Dog_machine").show()
		#get_node("/root/" + level + "/Kitchen/Root Scene/hot_dog_bun_box").show()
	

func _physics_process(_delta: float) -> void:
	
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
	
	
	if Input.is_action_just_pressed("force_win"):
		level_timer.paused = true
		level_timer.start(1)
		level_timer.paused = false
		
	if cop_present_bool == false:
		player.gauge.value = $cop_catch_timer.time_left*-20
		
func shutter_door_control():
	Global.shutter += 1
	print("Shutter Used: " + str(Global.shutter))
	if shutter_door_close == false:
		$ShutterDoor.hide()
		shutter_door_close = true
		door_shutter()
		if starting_counter == 0:
			$"../ShutterLabel".text = "Hide!"
			_on_new_customer()
			get_node("/root/" + level + "/Kitchen/Player/DayTimer").start()
			$LevelTimer.start()
			if level == "Beach":
				pass
			else:
				$CopTimer.start()
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
	

func _on_new_customer():
	#print("Your score is: ")
	#print(score)
	if starting_counter == 1 and level == "Beach":
		$CopTimer.start()
		print("Now we begin the game!!!")
	var scene = preload("res://customer/customer.tscn")
	var customer = scene.instantiate()
	customer.level = level
	customer.level_path = level.to_snake_case()
	print(customer.level_path)
	add_child(customer)
	timer_sign.customer = customer
	customer.position = %customer.position
	if level == "Area51":
		customer.position.y += .15
		
	
func _on_police():
	if lane_progression_counter <= 0:
		var scene = preload("res://police/police_car.tscn")
		var car = scene.instantiate()
		add_child(car)
		print("car spawned")
		car.global_rotation.y += 55
		car.scale.x = -1
		car.global_position = $"../CopCarSpawn".global_position
	else:
		var scene = preload("res://police/police.tscn")
		var police = scene.instantiate()
		add_child(police)
		var i = 0
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
		elif lane_progression_counter == 3:
			var audio_stream_player := AudioStreamPlayer.new()
			audio_stream_player.stream = load("res://audio/police_siren.wav")
			audio_stream_player.volume_db = linear_to_db(0.05)
			get_parent().add_child(audio_stream_player)
			audio_stream_player.play()
			audio_stream_player.finished.connect(func():
				audio_stream_player.queue_free()
			)
			i = randi()%1
			Global.police_spawns += 1
			police.scale = Vector3(1, 1, 1)
			if i == 0:
				police.position = $Close1.position
			elif i == 1:
				police.position = $Close2.position
			police.catch()
			cop_catch_timer.start()
			cop_present.emit(false)
			get_tree().call_group("customer", "selfhide")
			lane_progression_counter = -1
		

func policeRate():
	var rand = randf()
	print("Rand: %f" % rand)
	if rand <= .5:
		if lane_progression_counter < 3:
			lane_progression_counter += 1
			print("increase")
		else:
			lane_progression_counter = 0
			print("decrease")
	
	return lane_progression_counter
		
func _on_police_catch_timer_timeout():
	if can_police_catch_player == true:
		Global.police_catches = 1
		Global.end_of_level_money = score
		Global.save_data()
		get_tree().call_group("player", "lose_cam")
		await get_tree().create_timer(5).timeout
		get_tree().call_group("player", "lose_off")
		await get_tree().create_timer(.5).timeout
		get_tree().change_scene_to_file("res://menus/caught_scene.tscn")
		
		
	elif can_police_catch_player == false:
		cop_present.emit(true)
		Global.police_dodges += 1
		get_node("/root/" + level + "/Kitchen/Player/Control/CatchMeter").value = -100
		get_tree().call_group("police", "despawn")
		get_tree().call_group("customer", "selfshow")


func _on_level_timer_timeout():
	end_of_level.emit()
	print(score)
	Global.end_of_level_money = score
	Global.save_data()
	
	if level == "Beach" and score >= goal_score:
		Global.level_rave = 1
		Global.save_unlocked_levels()
	
	if level == "RaveKitchen" and score >= goal_score:
		Global.level_casino = 1
		Global.save_unlocked_levels()
	
	if level == "Casino" and score >= goal_score:
		Global.level_area51 = 1
		Global.save_unlocked_levels()
		
	if level == "Area51" and score >= goal_score:
		Global.level_endless = 1
		Global.save_unlocked_levels()
		
	
	await get_tree().create_timer(5).timeout
	get_tree().paused = true
	var scene = preload("res://menus/result_screen.tscn").instantiate()
	player.add_child(scene)
	if level == "Area51":
		Global.end = true
		print("TRUE!!!!!!!!!!")

	
func _spawn_police(modifier):
	if modifier < 0 or modifier > 3:
		pass
	else:
		cop_catch_timer.stop()
		get_tree().call_group("police", "despawn")
		lane_progression_counter = modifier
		_on_police()


func _on_cop_timer_timeout():
	print("Cop Timer Called")
	get_tree().call_group("police", "despawn")
	lane_progression_counter = policeRate()
	_on_police()
	print(poRate)
	$CopTimer.wait_time = 15
	$CopTimer.start()



func _on_area_3d_body_entered(body):
	if body.has_method("start_despawn"):
		body.start_despawn()


func _on_area_3d_body_exited(body):
	if body.has_method("cancel_despawn"):
		body.cancel_despawn()


func _on_cop_present(gone):
	cop_present_bool = gone

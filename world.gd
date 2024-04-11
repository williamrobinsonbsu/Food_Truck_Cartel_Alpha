extends Node3D

var shutter_door_close = false
var can_police_catch_player = false
var score = 0
var starting_counter = 0

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

#this happens when the radio is clicked on. 
func shutter_door_control():
	if shutter_door_close == false:
		$ShutterDoor.hide()
		shutter_door_close = true
		door_shutter()
		if starting_counter == 0:
			_on_new_customer()
			starting_counter += 1
		can_police_catch_player = false
	
	elif shutter_door_close == true:
		$ShutterDoor.show()
		shutter_door_close = false
		door_shutter()
		can_police_catch_player = true

func door_shutter():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://audio/shutter_open_close.wav")
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
		audio_stream_player.queue_free()
	)
#this allows us to code in a system where we can press a button to open or close
#the shutter door. Once we have the customer system fully working, we can add 
#in the police system and tweak this code to allow the player to be found by the
#police. Using 'can_police_catch_player' var as a placeholder for now.

func _on_new_customer():
	if starting_counter != 0:
		score += 100
	print("Your score is: ")
	print(score)
	var scene = preload("res://customer.tscn")
	var customer = scene.instantiate()
	add_child(customer)
	customer.position = %new_customer.position

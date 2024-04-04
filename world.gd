extends Node3D

@onready var police_catch_timer := $"../Police/PoliceCatchTimer"
@onready var policeman := $"../Police/Policeman"

var shutter_door_close = true
var can_police_catch_player = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func shutter_door_control():
	if shutter_door_close == false:
		can_police_catch_player = true
		$ShutterDoor.hide()
		shutter_door_close = true
		door_shutter()
	
	elif shutter_door_close == true:
		can_police_catch_player = false
		$ShutterDoor.show()
		shutter_door_close = false
		door_shutter()

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

func _on_police_spawn_timer_timeout():
	policeman.show()
	police_catch_timer.start()

func _on_police_catch_timer_timeout():
	if can_police_catch_player == true:
		print('you got caught')
	elif can_police_catch_player == false:
		policeman.hide()
		print('you did not get caught (this time)')

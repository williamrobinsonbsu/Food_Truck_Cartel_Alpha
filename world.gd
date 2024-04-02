extends Node3D

var shutter_door_close = false
var can_police_catch_player = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

#this happens when the radio is clicked on. 
func shutter_door_control():
	if shutter_door_close == false:
		$ShutterDoor.hide()
		shutter_door_close = true
		can_police_catch_player = false
	
	elif shutter_door_close == true:
		$ShutterDoor.show()
		shutter_door_close = false
		can_police_catch_player = true

#this allows us to code in a system where we can press a button to open or close
#the shutter door. Once we have the customer system fully working, we can add 
#in the police system and tweak this code to allow the player to be found by the
#police. Using 'can_police_catch_player' var as a placeholder for now.

extends RigidBody3D

var cutted_tomato = false

func cut_lettuce():
	if cutted_tomato == false:
		$tomato_whole.hide()
		$tomato_slice.show()
		cutted_tomato = true
		
func picked(picked):
	if picked == true:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	elif picked == false:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)

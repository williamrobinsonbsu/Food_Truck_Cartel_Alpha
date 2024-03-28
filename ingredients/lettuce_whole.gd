extends RigidBody3D

var cutted_lettuce = false

func cut_lettuce():
	if cutted_lettuce == false:
		$lettuce_whole.hide()
		$lettuce_slice.show()
		cutted_lettuce = true
		
func picked(picked):
	if picked == true:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	elif picked == false:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)

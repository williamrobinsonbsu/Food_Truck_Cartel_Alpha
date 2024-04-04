class_name PickedIngredient extends RigidBody3D

func picked(pick):
	if pick == true:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	elif pick == false:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		

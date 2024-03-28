class_name PickedIngredient extends RigidBody3D

func picked(picked):
	if picked == true:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	elif picked == false:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)

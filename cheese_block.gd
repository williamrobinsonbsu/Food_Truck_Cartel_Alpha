extends StaticBody3D

var scene = preload("res://ingredients/cheese_slice.tscn")

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

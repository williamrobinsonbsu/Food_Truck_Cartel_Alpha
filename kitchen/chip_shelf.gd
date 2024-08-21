extends StaticBody3D

var scene = preload("res://ingredients/chip_bag.tscn")

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

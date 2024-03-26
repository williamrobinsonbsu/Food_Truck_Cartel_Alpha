extends StaticBody3D

var scene = preload("res://ingredients/lettuce.tscn")

func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce

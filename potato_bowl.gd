extends StaticBody3D

var scene = preload("res://ingredients/potato_whole.tscn")

func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce

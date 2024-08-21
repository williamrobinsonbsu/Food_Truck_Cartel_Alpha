extends StaticBody3D

var scene = preload("res://ingredients/bottom_bun.tscn")

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

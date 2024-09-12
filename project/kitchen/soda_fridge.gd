extends StaticBody3D

var scene = preload("res://ingredients/soda_bottle.tscn")

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

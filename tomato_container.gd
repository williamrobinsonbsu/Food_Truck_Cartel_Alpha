extends StaticBody3D

var scene = preload("res://ingredients/tomato_whole.tscn")

func pick_item():
	var tomato = scene.instantiate()
	add_child(tomato)
	return tomato

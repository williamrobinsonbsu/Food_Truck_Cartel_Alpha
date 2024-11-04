extends StaticBody3D

var scene = preload("res://ingredients/hot_dog_bun.tscn")

func pick_item():
	var hot_dog = scene.instantiate()
	add_child(hot_dog)
	return hot_dog

extends StaticBody3D

var scene = preload("res://ingredients/cheese_slice.tscn")
func _ready():
	$ActionLabelCheese.hide()

func pick_item():
	var cheese = scene.instantiate()
	add_child(cheese)
	return cheese
	
func show_action():
	await $Player.hover
	$ActionLabel.show()

extends StaticBody3D

var scene = preload("res://ingredients/cheese_slice.tscn")
func _ready():
	$ActionLabelCheese.hide()

func pick_item():
	var cheese = scene.instantiate()
	add_child(cheese)
	return cheese

func hover_name():
	$ActionLabelCheese/LabelCheeseTimer.start()
	$ActionLabelCheese.show()
	
func _on_label_cheese_timer_timeout():
	$ActionLabelCheese.hide()

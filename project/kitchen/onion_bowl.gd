extends StaticBody3D

var scene = preload("res://ingredients/onion_whole.tscn")

func _ready():
	$ActionLabelOnion.hide()

func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce

func hover_name():
	$ActionLabelOnion/LabelOnionTimer.start()
	$ActionLabelOnion.show()

func _on_label_onion_timer_timeout():
	$ActionLabelOnion.hide()

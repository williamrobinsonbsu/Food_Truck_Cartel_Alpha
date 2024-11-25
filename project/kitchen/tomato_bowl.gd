extends StaticBody3D

var scene = preload("res://ingredients/tomato_whole.tscn")

func _ready():
	$ActionLabelTomato.hide()

func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce

func hover_name():
	$ActionLabelTomato/LabelTomatoTimer.start()
	$ActionLabelTomato.show()

func _on_label_tomato_timer_timeout():
	$ActionLabelTomato.hide()

extends StaticBody3D

var scene = preload("res://ingredients/potato_whole.tscn")

func _ready():
	$ActionLabelPotato.hide()

func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce

func hover_name():
	$ActionLabelPotato/LabelPotatoTimer.start()
	$ActionLabelPotato.show()

func _on_label_potato_timer_timeout():
	$ActionLabelPotato.hide()

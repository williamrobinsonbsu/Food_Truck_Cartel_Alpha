extends StaticBody3D

var scene = preload("res://ingredients/patty_raw.tscn")

func _ready():
	$ActionLabelPatty.hide()
	
func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce

func hover_name():
	$ActionLabelPatty/LabelPattyTimer.start()
	$ActionLabelPatty.show()

func _on_label_patty_timer_timeout():
	$ActionLabelPatty.hide()

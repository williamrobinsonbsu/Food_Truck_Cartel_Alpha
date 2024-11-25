extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionLabelStove.hide()

func hover_name():
	$ActionLabelStove/LabelStoveTimer.start()
	$ActionLabelStove.show()
	
func _on_label_stove_timer_timeout():
	$ActionLabelStove.hide()

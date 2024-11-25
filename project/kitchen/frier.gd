extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionLabelFryer.hide()
	
func hover_name():
	$ActionLabelFryer/LabelFryerTimer.start()
	$ActionLabelFryer.show()

func _on_label_fryer_timer_timeout():
	$ActionLabelFryer.hide()

extends StaticBody3D

var scene = preload("res://ingredients/lettuce_whole.tscn")

func _ready():
	$ActionLabelLettuce.hide()

func pick_item():
	var lettuce = scene.instantiate()
	add_child(lettuce)
	return lettuce
	
func hover_name():
	$ActionLabelLettuce/LabelLettuceTimer.start()
	$ActionLabelLettuce.show()


func _on_label_lettuce_timer_timeout():
	$ActionLabelLettuce.hide()

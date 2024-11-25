extends StaticBody3D

var scene = preload("res://ingredients/soda_bottle.tscn")

func _ready():
	$ActionLabelSoda.hide()

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

func hover_name():
	$ActionLabelSoda/LabelSodaTimer.start()
	$ActionLabelSoda.show()

func _on_label_soda_timer_timeout():
	$ActionLabelSoda.hide()

extends StaticBody3D

var scene = preload("res://ingredients/chip_bag.tscn")

func _ready():
	$ActionLabelChips.hide()

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

func hover_name():
	$ActionLabelChips/LabelChipsTimer.start()
	$ActionLabelChips.show()

func _on_label_chips_timer_timeout():
	$ActionLabelChips.hide()

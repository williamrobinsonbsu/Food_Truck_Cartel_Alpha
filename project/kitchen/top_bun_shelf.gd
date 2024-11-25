extends StaticBody3D

var scene = preload("res://ingredients/top_bun.tscn")

func _ready():
	$ActionLabelTopBun.hide()

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

func hover_name():
	$ActionLabelTopBun/LabelTopBunTimer.start()
	$ActionLabelTopBun.show()

func _on_label_top_bun_timer_timeout():
	$ActionLabelTopBun.hide()

extends StaticBody3D

var scene = preload("res://ingredients/bottom_bun.tscn")

func _ready():
	$ActionLabelBottomBun.hide()

func pick_item():
	var soda = scene.instantiate()
	add_child(soda)
	return soda

func hover_name():
	$ActionLabelBottomBun/LabelBottomBunTimer.start()
	$ActionLabelBottomBun.show()

func _on_label_bottom_bun_timer_timeout():
	$ActionLabelBottomBun.hide()

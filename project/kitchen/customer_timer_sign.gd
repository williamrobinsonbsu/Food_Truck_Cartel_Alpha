extends Node3D


@export var customer: StaticBody3D


func _process(_delta):
	if customer != null:
		$Label.text = str(int(customer.order_timer.time_left))
	else:
		$Label.text = ""

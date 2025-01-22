class_name PickedIngredient extends RigidBody3D


var picked_status
var on_floor

@onready var timer_path := preload("res://ingredients/queue_free_timer.tscn")
var timer: Timer


func picked(pick):
	if pick == true:
		if timer == null:
			timer = timer_path.instantiate()
			add_child(timer)
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		timer.paused = true
	elif pick == false:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		if on_floor == true:
			timer.paused = false
			timer.start(10)
			timer.timeout.connect(func():
				self.queue_free())
		
		

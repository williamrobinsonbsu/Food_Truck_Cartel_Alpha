extends ParallaxLayer


@export var Canyon_speed = -15.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	self.motion_offset.x += Canyon_speed * delta


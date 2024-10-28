extends ParallaxLayer


@export var shadow_speed = -15.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	self.motion_offset.x += shadow_speed * delta

extends ParallaxLayer

@export var road_speed = -50.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	self.motion_offset.x += road_speed * delta

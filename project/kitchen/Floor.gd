extends StaticBody3D

signal on_floor
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_area_3d_body_entered(body):
	if body.has_method("pickable"):
		on_floor.emit()

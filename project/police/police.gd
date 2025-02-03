extends StaticBody3D


func _ready():
	if Global.curr_level == "Area51":
		$PoliceFront.texture = load("res://police/area_51_guard_npc_front.png")
		$PoliceSide.texture = load("res://police/area_51_guard_npc_side.png")


func despawn():
	$".".queue_free()


func catch():
	$PoliceFront.show()
	$PoliceSide.hide()

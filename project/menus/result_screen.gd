extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_pressed():
	get_tree().change_scene_to_file("res://menus/road_map.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")

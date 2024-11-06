extends Control


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")


func _on_video_stream_player_finished():
	$VideoStreamPlayer.hide()

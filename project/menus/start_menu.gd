extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if MenuMusic.stream_paused == true:
		MenuMusic.play_music()
	LevelMusic.bus = "Music"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://menus/road_map.tscn")


func _on_quit_pressed():
	#Global.save_data()
	get_tree().quit()


func _on_settings_pressed():
	get_node("Options/CanvasLayer").show()
	


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://menus/Credits.tscn")

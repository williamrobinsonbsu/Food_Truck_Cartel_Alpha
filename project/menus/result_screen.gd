extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.end_of_level_money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	$CanvasLayer2/Label.text = "$" + str(Global.end_of_level_money);
	
	


func _on_next_pressed():
	get_tree().change_scene_to_file("res://menus/road_map.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_next_mouse_entered():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreenclicknext.png")

func _on_next_mouse_exited():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreen.png")
	

func _on_quit_mouse_entered():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreenclickquit.png")

func _on_quit_mouse_exited():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreen.png")
	

extends Control

signal closed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()



func _on_mute_toggled(toggled_on):
	AudioServer.set_bus_mute(0,toggled_on)


func _on_resolutions_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_window_size_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1152,648))
		1:
			DisplayServer.window_set_size(Vector2i(1980,1080))
		2:
			DisplayServer.window_set_size(Vector2i(1200,300))

func _on_back_button_pressed():
	$CanvasLayer.hide()
	closed.emit()
	

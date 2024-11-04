extends Control

## Emitted when the pause menu is dismissed.
signal dismissed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func show_pause_menu() -> void:
	$CanvasLayer.show()

func _on_resume_pressed():
	get_node("CanvasLayer").hide()
	dismissed.emit()


func _on_options_pressed():
	get_node("Options/CanvasLayer").show()
	get_node("CanvasLayer").hide()
	await $Options.closed
	$CanvasLayer.show()
	
	
func _on_quit_pressed():
	dismissed.emit()
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")
	
func _on_resume_mouse_entered():
	$CanvasLayer/PauseNote.texture = load("res://menus/Pause_Menu_Resume_Click.webp")

func _on_resume_mouse_exited():
	$CanvasLayer/PauseNote.texture = load("res://menus/Pause_Menu_UnClick.webp")

func _on_options_mouse_entered():
	$CanvasLayer/PauseNote.texture = load("res://menus/Pause_Menu_Options_Click.webp")

func _on_options_mouse_exited():
	$CanvasLayer/PauseNote.texture = load("res://menus/Pause_Menu_UnClick.webp")

func _on_quit_mouse_entered():
	$CanvasLayer/PauseNote.texture = load("res://menus/Pause_Menu_Quit_Click.webp")

func _on_quit_mouse_exited():
	$CanvasLayer/PauseNote.texture = load("res://menus/Pause_Menu_UnClick.webp")

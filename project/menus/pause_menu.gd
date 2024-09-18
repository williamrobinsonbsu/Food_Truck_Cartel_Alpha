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
	get_tree().quit()




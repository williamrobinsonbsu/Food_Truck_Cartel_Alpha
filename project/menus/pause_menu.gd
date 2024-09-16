extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

func _on_resume_pressed():
	get_node("CanvasLayer").hide()
	get_tree().paused = false


func _on_options_pressed():
	get_node("Options").show()
	get_node("CanvasLayer").hide()
	


func _on_quit_pressed():
	get_tree().quit()




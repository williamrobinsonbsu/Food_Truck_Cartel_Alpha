extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://levels/beach.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	$Title.hide()
	$Play.hide()
	$Quit.hide()
	get_node("Options/CanvasLayer").show()
	await $Options.closed
	$Title.show()
	$Play.show()
	$Quit.show()

extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_beach_pressed():
	get_tree().change_scene_to_file("res://levels/beach.tscn")

func _on_beach_mouse_entered():
	$placeholder.position = $Beach.position
	$placeholder.visible = true

func _on_beach_mouse_exited():
	$placeholder.visible = false

func _on_rave_pressed():
	get_tree().change_scene_to_file("res://levels/beach.tscn")

func _on_rave_mouse_entered():
	$placeholder.position = $Rave.position
	$placeholder.visible = true

func _on_rave_mouse_exited():
	$placeholder.visible = false


func _on_return_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")



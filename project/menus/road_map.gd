extends Control

var level_array = ["Level: beach, Difficulty: easy" , "Level: Rave, Difficulty: Medium", "Level: Casino, Difficulty: Hard", "Level: Area51, difficulty: Impossible"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_beach_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/beach.tscn")

func _on_beach_mouse_entered():
	$placeholder.position = $Beach.position
	$placeholder.visible = true
	$Text.text = level_array[0]
	$Text.position = $Beach.position + Vector2(110.0,-50)
	$Text.visible = true
func _on_beach_mouse_exited():
	$placeholder.visible = false
	$Text.visible = false

func _on_rave_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/rave_kitchen.tscn")

func _on_rave_mouse_entered():
	$placeholder.position = $Rave.position
	$placeholder.visible = true
	$Text.text = level_array[1]
	$Text.position = $Rave.position + Vector2(110.0,-50)
	$Text.visible = true
func _on_rave_mouse_exited():
	$placeholder.visible = false
	$Text.visible = false


func _on_return_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")


func _on_area_51_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/area51.tscn")


func _on_area_51_mouse_entered():
	$placeholder.position = $Area51.position
	$placeholder.visible = true
	$Text.text = level_array[3]
	$Text.position = $Area51.position + Vector2(110.0,-50)
	$Text.visible = true


func _on_area_51_mouse_exited():
	$placeholder.visible = false
	$Text.visible = false


func _on_casino_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/casino.tscn")


func _on_casino_mouse_entered():
	$placeholder.position = $Casino.position
	$placeholder.visible = true
	$Text.text = level_array[2]
	$Text.position = $Casino.position + Vector2(110.0,-50)
	$Text.visible = true


func _on_casino_mouse_exited():
	$placeholder.visible = false
	$Text.visible = false

func _play_loading_screen():
	var scene := preload("res://menus/loading_screen.tscn")
	var loading_screen = scene.instantiate()
	add_child(loading_screen)

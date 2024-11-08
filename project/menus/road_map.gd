extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _on_beach_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/beach.tscn")
	

func _on_beach_mouse_entered():
	$BeachLabel.visible = true

	
	
func _on_beach_mouse_exited():
	$BeachLabel.visible = false
	

func _on_rave_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/rave_kitchen.tscn")
	

func _on_rave_mouse_entered():
	$RaveLabel.visible = true

func _on_rave_mouse_exited():
	$RaveLabel.visible = false


func _on_return_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")


func _on_area_51_pressed():
	print("Locked")
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/area51.tscn")


func _on_area_51_mouse_entered():
	$Area51Label.visible = true



func _on_area_51_mouse_exited():
	$Area51Label.visible = false


func _on_casino_pressed():
	#print("Locked")
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/casino.tscn")


func _on_casino_mouse_entered():
	$CasinoLabel.visible = true



func _on_casino_mouse_exited():
	$CasinoLabel.visible = false

func _play_loading_screen():
	var scene := preload("res://menus/loading_screen.tscn")
	var loading_screen = scene.instantiate()
	add_child(loading_screen)

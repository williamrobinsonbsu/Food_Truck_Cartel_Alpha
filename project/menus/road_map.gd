extends Control


@onready var rave_button: Button = $Rave
@onready var casino_button: Button = $Casino
@onready var area51_button: Button = $Area51
@onready var endless_button: Button = $EndlessButton


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_unlocked_levels()
	
	if Global.level_rave == 0:
		$RaveIcon.modulate = Color.GRAY
		rave_button.disabled = true
		$RaveLabel.text = "Locked!"
	
	if Global.level_casino == 0:
		$CasinoIcon.modulate = Color.GRAY
		casino_button.disabled = true
		$CasinoLabel.text = "Locked!"
		
	if Global.level_area51 == 0:
		$Area51Icon.modulate = Color.GRAY
		area51_button.disabled = true
		$Area51Label.text = "Locked!"
	
	if Global.level_endless == 0:
		$EndlessIcon.hide()
		$EndlessIcon.modulate = Color.GRAY
		endless_button.disabled = true
		$EndlessLabel.text = "Locked!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
func _on_beach_pressed():
	_play_loading_screen()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://levels/beach.tscn")
	

func _on_beach_mouse_entered():
	$BeachLabel.visible = true
	$AnimationPlayer.play("beach_hover")

	
func _on_beach_mouse_exited():
	$BeachLabel.visible = false
	$AnimationPlayer.play("beach_idle")
	

func _on_rave_pressed():
	if Global.level_rave == 1:
		_play_loading_screen()
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://levels/rave_kitchen.tscn")
	

func _on_rave_mouse_entered():
	$RaveLabel.visible = true
	if Global.level_rave == 1:
		$AnimationPlayer.play("rave_hover")

func _on_rave_mouse_exited():
	$RaveLabel.visible = false
	$AnimationPlayer.play("rave_idle")


func _on_return_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")


func _on_area_51_pressed():
	if Global.level_area51 == 1:
		_play_loading_screen()
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://levels/area51.tscn")


func _on_area_51_mouse_entered():
	$Area51Label.visible = true
	if Global.level_area51 == 1:
		$AnimationPlayer.play("alien_hover")



func _on_area_51_mouse_exited():
	$Area51Label.visible = false
	$AnimationPlayer.play("alien_idle")


func _on_casino_pressed():
	if Global.level_casino == 1:
		_play_loading_screen()
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://levels/casino.tscn")


func _on_casino_mouse_entered():
	$CasinoLabel.visible = true
	if Global.level_casino == 1:
		$AnimationPlayer.play("casino_hover")


func _on_casino_mouse_exited():
	$CasinoLabel.visible = false
	$AnimationPlayer.play("casino_idle")

func _play_loading_screen():
	var scene := preload("res://menus/loading_screen.tscn")
	var loading_screen = scene.instantiate()
	add_child(loading_screen)


func _on_endless_button_pressed():
	if Global.level_endless == 1:
		_play_loading_screen()
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://levels/endless.tscn")


func _on_endless_button_mouse_entered():
	if Global.level_endless == 1:
		$EndlessLabel.visible = true


func _on_endless_button_mouse_exited():
	$EndlessLabel.visible = false


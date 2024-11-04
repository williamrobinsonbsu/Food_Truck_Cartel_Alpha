extends Control

var pickupAmount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	$CanvasLayer2/Label.text = "$" 
	await $Player.pickup
	pickupAmount += 1
	print(pickupAmount)


func _on_next_pressed():
	get_tree().change_scene_to_file("res://menus/road_map.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_next_mouse_entered():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreenclicknext.png")

func _on_next_mouse_exited():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreen.webp")
	

func _on_quit_mouse_entered():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreenclickquit.png")

func _on_quit_mouse_exited():
	$CanvasLayer/Resultscreen.texture = load("res://menus/resultscreen.webp")
	

extends StaticBody3D

var i_want_lettuce = false
var i_want_onion = false
var i_want_cheese = false
var i_want_tomato = false
var i_want_fries = false
var i_want_chips = false
var i_want_soda = false
var i_want_hot_dog = false
var i_want_burger = false
var npc_name
var curr_dialogue

@export var level: String
@export var level_path: String
var order
var counter = 0
@onready var texture: Sprite3D = $Sprite3D
@onready var world = get_node("/root/" + level +"/Kitchen/Root Scene")
@onready var dialogue = get_node("/root/" + level + "/Kitchen/NPCDialogue")
@onready var order_label: Label3D = get_node("/root/" + level + "/Kitchen/Root Scene/OrderLabel")
@onready var voice : ACVoiceBox = $ACVoicebox
@onready var patty = get_node("/root/" + level + "/Kitchen/order_plate/patty")
@onready var bottom_bun = get_node("/root/" + level + "/Kitchen/order_plate/bottom_bun")
@onready var top_bun = get_node("/root/" + level + "/Kitchen/order_plate/top_bun")
@onready var hot_dog = get_node("/root/" + level + "/Kitchen/order_plate/full_dog")
@onready var cheese = get_node("/root/" + level + "/Kitchen/order_plate/cheese")
@onready var tomato = get_node("/root/" + level + "/Kitchen/order_plate/tomatoes")
@onready var lettuce = get_node("/root/" + level + "/Kitchen/order_plate/lettuce")
@onready var onion = get_node("/root/" + level + "/Kitchen/order_plate/onions")
@onready var fries = get_node("/root/" + level + "/Kitchen/order_plate/fries")
@onready var soda = get_node("/root/" + level + "/Kitchen/order_plate/soda")
@onready var chips = get_node("/root/" + level + "/Kitchen/order_plate/chips")
@onready var plate = get_node("/root/" + level + "/Kitchen/order_plate/StaticBody3D")
@onready var clear_plate = get_node("/root/" + level + "/Kitchen/order_plate/ClearPlate")
@onready var dog = get_node("/root/" + level + "/Kitchen/Dog")
@onready var order_timer: Timer = $AssemblyTimer

signal new_customer


func _ready():
	texture.scale.x = -.07
	texture.scale = texture.scale*.9
	$AssemblyTimer.wait_time = $AssemblyTimer.wait_time / world.diff_modifier
	if level == "Beach":
		if world.starting_counter != 0:
			$AssemblyTimer.start()
		else:
			$OrderTimer.hide()
	else:
		$AssemblyTimer.start()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var npc = rng.randi_range(0, 6)
	print(npc)
	npc_name = ""
	npc_name = _get_npc(npc)
	$AnimationPlayer.play("slide_in")
	voice.play_string("Here is my order")
	curr_dialogue = DialogueManager.show_example_dialogue_balloon(load("res://customer/npcs/" + level_path + "/" + npc_name +"/dialogue.dialogue"), "normal")
	
	if level == "Casino" and randf() <= .3:
		print("I would like a hot dog")
		order = "hot dog"
		i_want_hot_dog = true
		counter += 1
		order_label.text = "-=+Current Order+=-\n- "+order+ " with: "
	else:
		print("I would like a burger!")
		i_want_burger = true
		order = "burger"
		order_label.text = "-=+Current Order+=-\n- "+order+ " with: "
	if randf() <= .50 and i_want_burger == true:
		i_want_lettuce = true
		counter += 1
		print("With lettuce")
		order_label.text += "\nLettuce"
	if randf() <= .10 and i_want_burger == true:
		i_want_tomato = true
		counter += 1
		print("With tomato")
		order_label.text += "\nTomato"
	if randf() <= .75 and i_want_burger == true:
		i_want_cheese = true
		counter += 1
		print("With cheese")
		order_label.text += "\nCheese"
	if randf() <= .45 and i_want_burger == true:
		i_want_onion = true
		counter += 1
		print("With onion")
		order_label.text += "\nOnion"
	order_label.text += "\n"
	if randf() <= .6:
		i_want_fries = true
		counter += 1
		print("With an order of fries!")
		order_label.text += "\n- Order of Fries"
	if randf() <= .1:
		i_want_chips = true
		counter += 1
		print("With chips!")
		order_label.text += "\n- Bag of Chips"
	if randf() <= .9:
		i_want_soda = true
		counter += 1
		print("With soda!")
		order_label.text += "\n- Bottle of Soda"


func _physics_process(_delta) -> void:
	if level == "Beach":
		if world.starting_counter != 0:
			$OrderTimer.text = str(int($AssemblyTimer.get_time_left()))
	else:
		$OrderTimer.text = str(int($AssemblyTimer.get_time_left()))
	#look_at(
	#	get_viewport().get_camera_3d().global_position,Vector3(0,1,0)
	#)
	
	if Input.is_action_just_pressed("pause") and curr_dialogue != null:
		curr_dialogue.queue_free()
	

	
func _on_check_my_order():
	var order_counter = 0
	var path
	if patty.visible != true and i_want_burger == true:
		print("Patty is missing")
	if hot_dog.visible != true and i_want_hot_dog == true:
		print("Hot Dog is missing")
	if hot_dog.visible == true and i_want_hot_dog == true:
		print("Hot Dog is correct")
		order_counter += 1
	if hot_dog.visible == true and i_want_hot_dog != true:
		print("Hot Dog is incorrect")
	if bottom_bun.visible != true and i_want_burger == true:
		print("Bottom bun is missing")
	if top_bun.visible != true and i_want_burger == true:
		print("Top bun is missing")
	if cheese.visible == true and i_want_cheese == true:
		print("Cheese is correct")
		order_counter += 1
	if cheese.visible != true and i_want_cheese == true:
		print("Cheese is missing")
	if cheese.visible == true and i_want_cheese != true:
		print("Cheese is incorrect")
	if tomato.visible == true and i_want_tomato == true:
		print("Tomato is correct")
		order_counter += 1
	if tomato.visible != true and i_want_tomato == true:
		print("Tomato is missing")
	if tomato.visible == true and i_want_tomato != true:
		print("Tomato is incorrect")
	if lettuce.visible == true and i_want_lettuce == true:
		print("Lettuce is correct")
		order_counter += 1
	if lettuce.visible != true and i_want_lettuce == true:
		print("Lettuce is missing")
	if lettuce.visible == true and i_want_lettuce != true:
		print("Lettuce is incorrect")
	if onion.visible == true and i_want_onion == true:
		print("Onions is correct")
		order_counter += 1
	if onion.visible != true and i_want_onion == true:
		print("Onions is missing")
	if onion.visible == true and i_want_onion != true:
		print("Onions is incorrect")
	if fries.visible == true and i_want_fries == true:
		print("Fries is correct")
		order_counter += 1
	if fries.visible != true and i_want_fries == true:
		print("Fries is missing")
	if fries.visible == true and i_want_fries != true:
		print("Fries is incorrect")
	if soda.visible == true and i_want_soda == true:
		print("Soda is correct")
		order_counter += 1
	if soda.visible != true and i_want_soda == true:
		print("Soda is missing")
	if soda.visible == true and i_want_soda != true:
		print("Soda is incorrect")
	if chips.visible == true and i_want_chips == true:
		print("Chips is correct")
		order_counter += 1
	if chips.visible != true and i_want_chips == true:
		print("Chips is missing")
	if chips.visible == true and i_want_chips != true:
		print("Chips is incorrect")
	
	
	
	if world.starting_counter == 0:
		world.score += 0
	elif order_counter == counter:
		path = "res://customer/npcs/" + level_path + "/" + npc_name + "/happy.png"
		var new_texture = load(path)
		texture.texture = new_texture
		curr_dialogue = DialogueManager.show_example_dialogue_balloon(load("res://customer/npcs/" + level_path + "/" + npc_name +"/dialogue.dialogue"), "happy")
		voice.play_string("Thank you so much")
		world.score += 10 + counter
		Global.succ_submit += 1
		print("Successful Submissions: " + str(Global.succ_submit))
	elif order_counter == 0:
		path = "res://customer/npcs/" + level_path + "/" + npc_name + "/mad.png"
		var new_texture = load(path)
		voice.play_string("What the hell")
		texture.texture = new_texture
		curr_dialogue = DialogueManager.show_example_dialogue_balloon(load("res://customer/npcs/" + level_path + "/" + npc_name +"/dialogue.dialogue"), "angry")
		world.score += 0
		Global.fai_submit += 1
		print("Failed Submissions: " + str(Global.fai_submit))
	else:
		path = "res://customer/npcs/" + level_path + "/" + npc_name + "/mad.png"
		var new_texture = load(path)
		voice.play_string("thanks, I guess")
		texture.texture = new_texture
		curr_dialogue = DialogueManager.show_example_dialogue_balloon(load("res://customer/npcs/" + level_path + "/" + npc_name +"/dialogue.dialogue"), "angry")
		world.score += 5
		Global.fai_submit += 1
		print("Failed Submissions: " + str(Global.fai_submit))
		
	get_node("/root/" + level + "/Kitchen/Root Scene/register/score").text = "$" + str(world.score)
	get_node("/root/" + level + "/Kitchen/order_plate/resetTemp").set_collision_mask_value(1, false)
	await get_tree().create_timer(3).timeout
	get_node("/root/" + level + "/Kitchen/order_plate/resetTemp").set_collision_mask_value(1, true)
		
	
	get_tree().call_group("map", "_spawn_new_customer_or_cop")
	if world.lane_progression_counter != 3:
		get_tree().call_group("police", "despawn")
	$".".queue_free()
		


func _on_assembly_timer_timeout():
	dog.visible = true
	world.score += 0
	Global.fai_submit += 1
	get_tree().call_group("map", "_spawn_new_customer_or_cop")
	get_tree().call_group("police", "despawn")
	$".".queue_free()
	plate._on_clear_plate_clear_plate()
	clear_plate.reset()
	

func _on_voicebox_characters_sounded(characters: String):
	dialogue.text += characters

func _get_npc(npc):   #update for every new npc
	var path
	dog.visible = false
	if level_path == "rave_kitchen":
		var rng = RandomNumberGenerator.new()
		npc = rng.randi_range(0, 3)
	elif level_path == "casino":
		var rng = RandomNumberGenerator.new()
		npc = rng.randi_range(0, 4)
	elif level_path == "area_51":
		var rng = RandomNumberGenerator.new()
		npc = rng.randi_range(0, 4)
	
	if npc == 0:
		npc_name = "npc0"
		voice.base_pitch = 4
	elif npc == 1:
		npc_name = "npc1"
		voice.base_pitch = 3
	elif npc == 2: 
		npc_name = "npc2"
		voice.base_pitch = 2
	elif npc == 3:
		npc_name = "npc3"
		voice.base_pitch = 1
	elif npc == 4:
		npc_name = "npc4"
		voice.base_pitch = 3
	elif npc == 5:
		npc_name = "npc5"
		voice.base_pitch = 5
	elif npc == 6:
		npc_name = "npc6"
		voice.base_pitch = 2
	
	
	path = "res://customer/npcs/" + level_path + "/" + npc_name + "/normal.png"
	var new_texture = load(path)
	
	texture.texture = new_texture
	#$ACVoicebox.play_string("HHi! Here's my order")
	#dialogue.text = "Hi! Here's my order."
	return npc_name


func toggle_assembly_timer():
	if $AssemblyTimer.paused == true:
		$AssemblyTimer.paused = false
	elif $AssemblyTimer.paused == false:
		$AssemblyTimer.paused = true


func selfhide():
	self.hide()
	$AssemblyTimer.paused = true


func selfshow():
	self.show()
	$AssemblyTimer.paused = false

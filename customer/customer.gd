extends StaticBody3D

var i_want_lettuce = false
var i_want_onion = false
var i_want_cheese = false
var i_want_tomato = false
var i_want_fries = false
var i_want_chips = false
var i_want_soda = false
var npc_name

var counter = 0
@onready var world = get_node("/root/World/Root Scene")
@onready var dialogue = get_node("/root/World/NPCDialogue")
signal new_customer

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var npc = rng.randi_range(0, 2)
	print(npc)
	npc_name = ""
	npc_name = _get_npc(npc)
	
	
	print("I would like a burger!")
	get_node("/root/World/Root Scene/OrderLabel").text = "-=+Current Order+=-\n- Burger with: "
	if randf() <= .50:
		i_want_lettuce = true
		counter += 1
		print("With lettuce")
		get_node("/root/World/Root Scene/OrderLabel").text += "\nLettuce"
	if randf() <= .10:
		i_want_tomato = true
		counter += 1
		print("With tomato")
		get_node("/root/World/Root Scene/OrderLabel").text += "\nTomato"
	if randf() <= .75:
		i_want_cheese = true
		counter += 1
		print("With cheese")
		get_node("/root/World/Root Scene/OrderLabel").text += "\nCheese"
	if randf() <= .45:
		i_want_onion = true
		counter += 1
		print("With onion")
		get_node("/root/World/Root Scene/OrderLabel").text += "\nOnion"
	get_node("/root/World/Root Scene/OrderLabel").text += "\n"
	if randf() <= .6:
		i_want_fries = true
		counter += 1
		print("With an order of fries!")
		get_node("/root/World/Root Scene/OrderLabel").text += "\n- Order of Fries"
	if randf() <= .1:
		i_want_chips = true
		counter += 1
		print("With chips!")
		get_node("/root/World/Root Scene/OrderLabel").text += "\n- Bag of Chips"
	if randf() <= .9:
		i_want_soda = true
		counter += 1
		print("With soda!")
		get_node("/root/World/Root Scene/OrderLabel").text += "\n- Bottle of Soda"
	
func _on_check_my_order():
	var order_counter = 0
	if get_node("/root/World/order_plate/patty").visible != true:
		print("Patty is missing")
	if get_node("/root/World/order_plate/bottom_bun").visible != true:
		print("Bottom bun is missing")
	if get_node("/root/World/order_plate/top_bun").visible != true:
		print("Top bun is missing")
	if get_node("/root/World/order_plate/cheese").visible == true and i_want_cheese == true:
		print("Cheese is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/cheese").visible != true and i_want_cheese == true:
		print("Cheese is missing")
	if get_node("/root/World/order_plate/cheese").visible == true and i_want_cheese != true:
		print("Cheese is incorrect")
	if get_node("/root/World/order_plate/tomatoes").visible == true and i_want_tomato == true:
		print("Tomato is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/tomatoes").visible != true and i_want_tomato == true:
		print("Tomato is missing")
	if get_node("/root/World/order_plate/tomatoes").visible == true and i_want_tomato != true:
		print("Tomato is incorrect")
	if get_node("/root/World/order_plate/lettuce").visible == true and i_want_lettuce == true:
		print("Lettuce is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/lettuce").visible != true and i_want_lettuce == true:
		print("Lettuce is missing")
	if get_node("/root/World/order_plate/lettuce").visible == true and i_want_lettuce != true:
		print("Lettuce is incorrect")
	if get_node("/root/World/order_plate/onions").visible == true and i_want_onion == true:
		print("Onions is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/onions").visible != true and i_want_onion == true:
		print("Onions is missing")
	if get_node("/root/World/order_plate/onions").visible == true and i_want_onion != true:
		print("Onions is incorrect")
	if get_node("/root/World/order_plate/fries").visible == true and i_want_fries == true:
		print("Fries is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/fries").visible != true and i_want_fries == true:
		print("Fries is missing")
	if get_node("/root/World/order_plate/fries").visible == true and i_want_fries != true:
		print("Fries is incorrect")
	if get_node("/root/World/order_plate/soda").visible == true and i_want_soda == true:
		print("Soda is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/soda").visible != true and i_want_soda == true:
		print("Soda is missing")
	if get_node("/root/World/order_plate/soda").visible == true and i_want_soda != true:
		print("Soda is incorrect")
	if get_node("/root/World/order_plate/chips").visible == true and i_want_chips == true:
		print("Chips is correct")
		order_counter += 1
	if get_node("/root/World/order_plate/chips").visible != true and i_want_chips == true:
		print("Chips is missing")
	if get_node("/root/World/order_plate/chips").visible == true and i_want_chips != true:
		print("Chips is incorrect")
	
	
	
	if world.starting_counter == 0:
		world.score += 0
	elif order_counter == counter:
		world.score += 10 + counter
		npc_name += "Happy"
		dialogue.text = "Thanks!"
		get_node(npc_name).show()
	elif order_counter == 0:
		world.score += 1
		dialogue.text = "Seriously?"
	else:
		world.score += 5
		npc_name += "Angry"
		dialogue.text = "..."
		get_node(npc_name).show()
		
	get_node("/root/World/Root Scene/register/score").text = "$" + str(world.score)
	get_node("/root/World/order_plate/resetTemp").set_collision_layer_value(1, false)
	await get_tree().create_timer(3).timeout
	get_node("/root/World/order_plate/resetTemp").set_collision_layer_value(1, true)
		
	
	get_tree().call_group("map", "_spawn_new_customer_or_cop")
	if world.laneProgressionCounter != 3:
		get_tree().call_group("police", "despawn")
	$".".queue_free()
		


func _on_assembly_timer_timeout():
	world.score += 0
	get_tree().call_group("map", "_spawn_new_customer_or_cop")
	get_tree().call_group("police", "despawn")
	$".".queue_free()

func _get_npc(npc):   #update for every new npc
	var npcName
	if npc == 0:
		$NPCBlondie.show()
		npcName = "NPCBlondie/NPCBlondie"
	elif npc == 1:
		$NPCLifeguard.show()
		npcName = "NPCLifeguard/NPCLifeguard"
	elif npc == 2: 
		$NPCSurfer.show()
		npcName = "NPCSurfer/NPCSurfer"
	
	dialogue.text = "Hi! Here's my order."
	return npcName

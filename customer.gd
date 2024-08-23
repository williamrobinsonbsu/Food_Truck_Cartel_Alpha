extends StaticBody3D

var i_want_lettuce = false
var i_want_onion = false
var i_want_cheese = false
var i_want_tomato = false
var i_want_fries = false
var i_want_chips = false
var i_want_soda = false

var counter = 0
signal new_customer

func _ready():
	print("I would like a burger!")
	#get_node("/root/World/Player/Control/current_order").text = "-=+Current Order+=-\nBurger with: "
	get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text = "-=+Current Order+=-\nBurger with: "
	if randf() <= .50:
		i_want_lettuce = true
		counter += 1
		print("With lettuce")
		#get_node("/root/World/Player/Control/current_order").text += "\nLettuce"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nLettuce"
	if randf() <= .10:
		i_want_tomato = true
		counter += 1
		print("With tomato")
		#get_node("/root/World/Player/Control/current_order").text += "\nTomato"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nTomato"
	if randf() <= .75:
		i_want_cheese = true
		counter += 1
		print("With cheese")
		#get_node("/root/World/Player/Control/current_order").text += "\nCheese"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nCheese"
	if randf() <= .45:
		i_want_onion = true
		counter += 1
		print("With onion")
		#get_node("/root/World/Player/Control/current_order").text += "\nOnion"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nOnion"
	if randf() <= .6:
		i_want_fries = true
		counter += 1
		print("With an order of fries!")
		#get_node("/root/World/Player/Control/current_order").text += "\nAn order of fries"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nAn order of fries"
	if randf() <= .1:
		i_want_chips = true
		counter += 1
		print("With chips!")
		#get_node("/root/World/Player/Control/current_order").text += "\nWith chips"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nWith chips"
	if randf() <= .9:
		i_want_soda = true
		counter += 1
		print("With soda!")
		#get_node("/root/World/Player/Control/current_order").text += "\nWith soda"
		get_node("/root/World/Player/CanvasLayer/HBoxContainer/Hud/Label").text += "\nWith soda"
	
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
	
	
	
	if order_counter == counter:
		get_node("/root/World/Player/Control/current_order").text = ""
		get_tree().call_group("map", "_spawn_new_customer_or_cop")
		$".".queue_free()
		

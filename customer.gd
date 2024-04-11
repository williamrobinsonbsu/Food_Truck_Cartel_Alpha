extends StaticBody3D

var i_want_lettuce = false
var i_want_onion = false
var i_want_cheese = false
var i_want_tomato = false
var i_want_fries = false

var counter = 0

signal new_customer

func _ready():
	print("I would like a burger!")
	get_node("/root/World/Player/Control/current_order").text += "Current Order:\n Burger with "
	if randf() <= .50:
		i_want_lettuce = true
		counter += 1
		print("With lettuce")
		get_node("/root/World/Player/Control/current_order").text += "lettuce, "
	if randf() <= .10:
		i_want_tomato = true
		counter += 1
		print("With tomato")
		get_node("/root/World/Player/Control/current_order").text += "tomato, "
	if randf() <= .75:
		i_want_cheese = true
		counter += 1
		print("With cheese")
		get_node("/root/World/Player/Control/current_order").text += "cheese, "
	if randf() <= .45:
		i_want_onion = true
		counter += 1
		print("With onion")
		get_node("/root/World/Player/Control/current_order").text += "onion, "
	if randf() <= .6:
		i_want_fries = true
		counter += 1
		print("With an order of fries!")
		get_node("/root/World/Player/Control/current_order").text += "and an order of fries"
	
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
	
	if order_counter == counter:
		get_tree().call_group("map", "_on_new_customer")
		$".".queue_free()

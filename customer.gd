extends StaticBody3D

var i_want_lettuce = false
var i_want_onion = false
var i_want_cheese = false
var i_want_tomato = false
var i_want_fries = false

func _ready():
	print("I would like a burger!")
	if randf() <= .50:
		i_want_lettuce = true
		print("With lettuce")
	if randf() <= .10:
		i_want_tomato = true
		print("With tomato")
	if randf() <= .75:
		i_want_cheese = true
		print("With cheese")
	if randf() <= .45:
		i_want_onion = true
		print("With onion")
	if randf() <= .6:
		i_want_fries = true
		print("With an order of fries!")
		
func _on_check_my_order():
	if $"../order_plate/patty".visible != true:
		print("Patty is missing")
	if $"../order_plate/bottom_bun".visible != true:
		print("Bottom bun is missing")
	if $"../order_plate/top_bun".visible != true:
		print("Top bun is missing")
	if $"../order_plate/cheese".visible == true and i_want_cheese == true:
		print("Cheese is correct")
	if $"../order_plate/cheese".visible != true and i_want_cheese == true:
		print("Cheese is missing")
	if $"../order_plate/cheese".visible == true and i_want_cheese != true:
		print("Cheese is incorrect")
	if $"../order_plate/tomatoes".visible == true and i_want_tomato == true:
		print("Tomato is correct")
	if $"../order_plate/tomatoes".visible != true and i_want_tomato == true:
		print("Tomato is missing")
	if $"../order_plate/tomatoes".visible == true and i_want_tomato != true:
		print("Tomato is incorrect")
	if $"../order_plate/lettuce".visible == true and i_want_lettuce == true:
		print("Lettuce is correct")
	if $"../order_plate/lettuce".visible != true and i_want_lettuce == true:
		print("Lettuce is missing")
	if $"../order_plate/lettuce".visible == true and i_want_lettuce != true:
		print("Lettuce is incorrect")
	if $"../order_plate/onions".visible == true and i_want_onion == true:
		print("Onions is correct")
	if $"../order_plate/onions".visible != true and i_want_onion == true:
		print("Onions is missing")
	if $"../order_plate/onions".visible == true and i_want_onion != true:
		print("Onions is incorrect")
	if $"../order_plate/fries".visible == true and i_want_fries == true:
		print("Fries is correct")
	if $"../order_plate/fries".visible != true and i_want_fries == true:
		print("Fries is missing")
	if $"../order_plate/fries".visible == true and i_want_fries != true:
		print("Fries is incorrect")

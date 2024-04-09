extends StaticBody3D

signal reset_ingredients

func reset():
	reset_ingredients.emit()
	$"../bottom_bun".hide()
	$"../patty".hide()
	$"../onions".hide()
	$"../lettuce".hide()
	$"../tomatoes".hide()
	$"../cheese".hide()
	$"../top_bun".hide()
	$"../fries".hide()

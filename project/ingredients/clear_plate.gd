extends StaticBody3D


signal clear_plate


func reset():
	clear_plate.emit()
	$"../bottom_bun".hide()
	$"../patty".hide()
	$"../onions".hide()
	$"../lettuce".hide()
	$"../tomatoes".hide()
	$"../cheese".hide()
	$"../top_bun".hide()
	$"../fries".hide()
	$"../soda".hide()
	$"../chips".hide()
	$"../hot_dog".hide()

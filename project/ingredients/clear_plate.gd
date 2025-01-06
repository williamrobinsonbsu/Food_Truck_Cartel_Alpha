extends StaticBody3D


signal clear_plate


func reset():
	Global.clear += 1
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
	$"../full_dog".hide()
	$"../hot_dog_bun".hide()

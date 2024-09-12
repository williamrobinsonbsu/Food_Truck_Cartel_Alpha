extends StaticBody3D

signal reset_ingredients

func reset():
	if get_node("/root/World/Root Scene").door_status() == true:
		reset_ingredients.emit()
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

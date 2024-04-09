extends StaticBody3D

var bottom_placed = false
var patty_placed = false

func place(picked_object):
	if picked_object != null:
		if picked_object.name() == "burger":
			$"../bottom_bun".show()
			bottom_placed = true
			picked_object.queue_free()
		elif picked_object.name() == "boxed fries":
			$"../fries".show()
			picked_object.queue_free()
		elif bottom_placed == true:
			if picked_object.name() == "patty":
				$"../patty".show()
				patty_placed = true
				picked_object.queue_free()
				
		if patty_placed == true:
			if picked_object.name() == "sliced onions":
				$"../onions".show()
			elif picked_object.name() == "sliced lettuce":
				$"../lettuce".show()
			elif picked_object.name() == "sliced tomatoes":
				$"../tomatoes".show()
			elif picked_object.name() == "cheese slice":
				$"../cheese".show()
			elif picked_object.name() == "top bun":
				$"../top_bun".show()
	
			picked_object.queue_free()


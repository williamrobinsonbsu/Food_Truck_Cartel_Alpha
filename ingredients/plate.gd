extends StaticBody3D

var bottom_bun_placed = false
var patty_placed = false
var lettuce_placed = false
var tomato_placed = false
var onion_placed = false
var cheese_placed = false
var top_bun_placed = false

signal check_my_order

func place(picked_object):
	if picked_object != null:
		if picked_object.has_method("name"):
			if picked_object.name() == "burger":
				$"../bottom_bun".show()
				bottom_bun_placed = true
				picked_object.queue_free()
			elif picked_object.name() == "boxed fries":
				$"../fries".show()
				picked_object.queue_free()
			elif bottom_bun_placed == true:
				if picked_object.name() == "patty":
					$"../patty".show()
					patty_placed = true
					picked_object.queue_free()
		
		if picked_object.has_method("slice_name"):		
			if patty_placed == true:
				if picked_object.slice_name() == "sliced onions":
					$"../onions".show()
					onion_placed = true
				elif picked_object.slice_name() == "sliced lettuce":
					$"../lettuce".show()
					lettuce_placed = true
				elif picked_object.slice_name() == "sliced tomatoes":
					$"../tomatoes".show()
					tomato_placed = true
				elif picked_object.slice_name() == "cheese slice":
					$"../cheese".show()
					cheese_placed = true
				elif picked_object.slice_name() == "top bun":
					$"../top_bun".show()
					top_bun_placed = true
	
				picked_object.queue_free()

func _on_reset_ingredients():
	get_tree().call_group("customer", "_on_check_my_order")
	bottom_bun_placed = false
	cheese_placed = false
	lettuce_placed = false
	onion_placed = false
	patty_placed = false
	tomato_placed = false
	top_bun_placed = false
	

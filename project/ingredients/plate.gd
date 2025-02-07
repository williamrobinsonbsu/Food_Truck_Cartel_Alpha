extends StaticBody3D

var bottom_bun_placed = false
var patty_placed = false
var lettuce_placed = false
var tomato_placed = false
var onion_placed = false
var cheese_placed = false
var top_bun_placed = false
var hot_dog_placed = false
var fries_placed = false
var soda_placed = false
var chips_placed = false
var dog_bun_placed = false
signal check_my_order

func place(picked_object):
	var level = get_parent().get_parent().get_parent().name
	if picked_object != null:
		if picked_object.has_method("name"):
			if picked_object.name() == "burger" and bottom_bun_placed != true:
				$"../bottom_bun".show()
				bottom_bun_placed = true
				picked_object.queue_free()
			elif picked_object.name() == "hot_dog_bun" and dog_bun_placed != true:
				$"../hot_dog_bun".show()
				dog_bun_placed = true
				picked_object.queue_free()
			elif picked_object.name() == "boxed fries" and fries_placed != true:
				$"../fries".show()
				fries_placed = true
				picked_object.queue_free()
			elif picked_object.name() == "soda" and soda_placed != true:
				$"../soda".show()
				soda_placed = true
				picked_object.queue_free()
			elif picked_object.name() == "chips" and chips_placed != true:
				$"../chips".show()
				chips_placed = true
				picked_object.queue_free()	
			elif bottom_bun_placed == true:
				if picked_object.name() == "patty" and patty_placed != true:
					$"../patty".show()
					patty_placed = true
					picked_object.queue_free()
			elif dog_bun_placed == true:
				if picked_object.name() == "hot_dog" and hot_dog_placed != true:
					$"../full_dog".show()
					$"../hot_dog_bun".hide()
					hot_dog_placed = true
					picked_object.queue_free()
		
		if picked_object.has_method("slice_name"):		
			if patty_placed == true:
				if picked_object.slice_name() == "sliced onions" and onion_placed != true:
					$"../onions".show()
					onion_placed = true
					picked_object.queue_free()
				elif picked_object.slice_name() == "sliced lettuce" and lettuce_placed != true:
					$"../lettuce".show()
					lettuce_placed = true
					picked_object.queue_free()
				elif picked_object.slice_name() == "sliced tomatoes" and tomato_placed != true:
					$"../tomatoes".show()
					tomato_placed = true
					picked_object.queue_free()
				elif picked_object.slice_name() == "cheese slice" and cheese_placed != true:
					$"../cheese".show()
					cheese_placed = true
					picked_object.queue_free()
				elif picked_object.slice_name() == "top bun" and top_bun_placed != true:
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
	hot_dog_placed = false
	dog_bun_placed = false
	tomato_placed = false


func _on_clear_plate_clear_plate():
	bottom_bun_placed = false
	cheese_placed = false
	lettuce_placed = false
	onion_placed = false
	patty_placed = false
	tomato_placed = false
	top_bun_placed = false
	dog_bun_placed = false
	tomato_placed = false
	hot_dog_placed = false


func _on_area_3d_body_entered(body):
	if body.has_method("name") or body.has_method("slice_name"):
		place(body)

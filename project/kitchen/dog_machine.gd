extends StaticBody3D

var scene = preload("res://ingredients/hot_dog.tscn")

func use(ingredient):
	if ingredient.has_method("name") and ingredient.name() == "hot_dog_raw":
		$Hot_dog_raw.show()
		ingredient.audio_play_grill()
		$Hot_dog_raw.set_collision_layer_value(1, false)
		ingredient.queue_free()
		await get_tree().create_timer(5).timeout
		$Hot_dog_raw.hide()
		var patty = scene.instantiate()
		add_child(patty)
		patty.position = %CookedPatty.position
	else:
		pass
		
		

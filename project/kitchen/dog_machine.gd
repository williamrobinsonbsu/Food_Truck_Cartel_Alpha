extends StaticBody3D

var scene = preload("res://ingredients/hot_dog.tscn")

func use(ingredient):
	if ingredient.has_method("name") and ingredient.name() == "hot_dog_raw":
		$Hot_dog_raw.show()
		ingredient.audio_play_grill()
		ingredient.queue_free()
		await get_tree().create_timer(5).timeout
		$Hot_dog_raw.hide()
		var patty = scene.instantiate()
		add_child(patty)
		patty.position = %CookedPatty.position
	else:
		pass
		
		


func _on_area_3d_body_entered(body):
	if body.has_method("cooks") and body.cooks() == false:
			use(body)



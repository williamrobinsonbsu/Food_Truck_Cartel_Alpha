extends StaticBody3D

var scene = preload("res://ingredients/patty.tscn")
var cooking := false

func use(ingredient):
	if ingredient.has_method("name") and ingredient.name() == "patty_raw" and cooking == false:
		$PattyRaw.show()
		Global.grill_used += 1
		cooking = true
		ingredient.audio_play_grill()
		#$PattyRaw.set_collision_layer_value(1, false)
		ingredient.queue_free()
		await get_tree().create_timer(5).timeout
		$PattyRaw.hide()
		var patty = scene.instantiate()
		add_child(patty)
		patty.position = %CookedPatty.position
		cooking = false
	else:
		pass
		
		

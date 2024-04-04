extends PickedIngredient

func picked(pick):
	if pick == true:
		var audio_stream_player := AudioStreamPlayer.new()
		audio_stream_player.stream = load("res://audio/glass_clink.wav")
		get_parent().add_child(audio_stream_player)
		audio_stream_player.play()
		audio_stream_player.finished.connect(func():
			audio_stream_player.queue_free()
		)

		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	elif pick == false:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		

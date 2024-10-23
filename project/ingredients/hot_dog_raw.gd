extends PickedIngredient

func audio_play_grill():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://audio/grill_sizzle.wav")
	audio_stream_player.bus = "Sound"
	#audio_stream_player.volume_db = linear_to_db(.3)
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	await get_tree().create_timer(3).timeout
	audio_stream_player.queue_free()
	

func name():
	return "hot_dog_raw"

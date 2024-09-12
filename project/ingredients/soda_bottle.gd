extends PickedIngredient

func audio_play():
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://audio/glass_clink.wav")
	audio_stream_player.volume_db = linear_to_db(.3)
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
		audio_stream_player.queue_free()
	)
	
func name():
	return "soda"

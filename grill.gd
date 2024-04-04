extends StaticBody3D

func use(_body):	
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.stream = load("res://audio/grill_sizzle.wav")
	get_parent().add_child(audio_stream_player)
	audio_stream_player.play()
	audio_stream_player.finished.connect(func():
		audio_stream_player.queue_free()
	)

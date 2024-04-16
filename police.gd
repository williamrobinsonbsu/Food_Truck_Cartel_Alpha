extends StaticBody3D

func _ready():
	var audio_stream_player := AudioStreamPlayer.new()
	get_parent().add_child(audio_stream_player)
	for i in 3:
		audio_stream_player.stream = load("res://audio/police_siren.wav")
		audio_stream_player.play()
		await audio_stream_player.finished
	audio_stream_player.queue_free()

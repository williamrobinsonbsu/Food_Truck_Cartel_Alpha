extends StaticBody3D


signal reset_ingredients
var level: String


func reset():
	level = get_parent().get_parent().get_parent().name
	if get_node("/root/" + level + "/Kitchen/Root Scene").door_status() == true:
		var audio_stream_player := AudioStreamPlayer.new()
		audio_stream_player.bus = "Sound"
		audio_stream_player.stream = load("res://audio/newSounds/bell.wav")
		get_parent().add_child(audio_stream_player)
		audio_stream_player.play()
		audio_stream_player.finished.connect(func():
				audio_stream_player.queue_free()
				)
		reset_ingredients.emit()
		$"../bottom_bun".hide()
		$"../patty".hide()
		$"../onions".hide()
		$"../lettuce".hide()
		$"../tomatoes".hide()
		$"../cheese".hide()
		$"../top_bun".hide()
		$"../fries".hide()
		$"../soda".hide()
		$"../chips".hide()
		$"../full_dog".hide()

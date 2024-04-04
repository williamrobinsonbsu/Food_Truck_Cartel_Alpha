extends StaticBody3D

var cutting_noise_played = 0

func get_ingredient(ingredient): 
	var path = "res://ingredients/" + ingredient + "_slice.tscn"
	var scene = null
	if FileAccess.file_exists(path):
		scene = load(path)
		print(scene)
	else:
		pass
	return scene

func use(ingredient):
	var count = 0
	if ingredient.has_method("name"):
		var scene = get_ingredient(ingredient.name())
		while count != 3:
			var sliced_ingredient = scene.instantiate()
			add_child(sliced_ingredient)
			sliced_ingredient.position = %CuttingBoardMarker.position
			count += 1
		ingredient.queue_free()
	else:
		pass
	
	var audio_stream_player := AudioStreamPlayer.new()
	get_parent().add_child(audio_stream_player)
	for i in 3:
		audio_stream_player.stream = load("res://audio/chopping_sound.wav")
		audio_stream_player.play()
		await audio_stream_player.finished
	audio_stream_player.queue_free()

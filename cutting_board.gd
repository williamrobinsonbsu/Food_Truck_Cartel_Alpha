extends StaticBody3D

var path
var scene

func get_ingredient(ingredient): 
	path = "res://ingredients/" + ingredient + "_slice.tscn"
	scene = null
	print(path)
	print(FileAccess.file_exists(path))
	if FileAccess.file_exists(path):
		scene = load(path)
		print(scene)
		return scene
	else:
		pass
	

func use(ingredient):
	print("Clicked!")
	print(ingredient)
	var count = 0
	if ingredient.has_method("name"):
		print("Slice!")
		var scene = get_ingredient(ingredient.name())
		if scene == null:
				return
		while count != 3:
			var sliced_ingredient = scene.instantiate()
			add_child(sliced_ingredient)
			sliced_ingredient.position = %CuttingBoardMarker.position
			count += 1
		ingredient.queue_free()
		var audio_stream_player := AudioStreamPlayer.new()
		get_parent().add_child(audio_stream_player)
		for i in 3:
			audio_stream_player.stream = load("res://audio/chopping_sound.wav")
			audio_stream_player.play()
			await audio_stream_player.finished
		audio_stream_player.queue_free()

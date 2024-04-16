extends StaticBody3D

var scene

var tomato_scene = preload("res://ingredients/tomato_slice.tscn")
var lettuce_scene = preload("res://ingredients/lettuce_slice.tscn")
var fries_scene = preload("res://ingredients/potato_slice.tscn")
var onion_scene = preload("res://ingredients/onion_slice.tscn")

func get_ingredient(ingredient): 
	print(ingredient)
	if ingredient == "tomato":
		scene = tomato_scene
	elif ingredient == "lettuce":
		scene = lettuce_scene
	elif ingredient == "fries":
		scene = fries_scene
	elif ingredient == "onion":
		scene = onion_scene
	else:
		scene = null
	return scene
	
	

func use(ingredient):
	var count = 0
	if ingredient.has_method("name"):
		scene = get_ingredient(ingredient.name())
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

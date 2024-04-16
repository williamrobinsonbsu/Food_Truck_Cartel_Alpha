extends StaticBody3D

func get_ingredient(ingredient): 
	var path = "res://ingredients/" + ingredient + "_slice.tscn"
	var scene = null
	if FileAccess.file_exists(path):
		scene = load(path)
		print(scene)
		return scene
	else:
		pass
	

func use(ingredient):
	var count = 0
	if ingredient.has_method("name"):
		var scene = get_ingredient(ingredient.name())
		if scene == null:
				return
		while count != 3:
			
			var sliced_ingredient = scene.instantiate()
			add_child(sliced_ingredient)
			sliced_ingredient.position = %CuttingBoardMarker.position
			count += 1
		ingredient.queue_free()
	

extends StaticBody3D

var scene = preload("res://ingredients/boxed_fries.tscn")

func use(ingredient):
	if ingredient.has_method("slice_name") and ingredient.slice_name() == "fries":
		var sliced_ingredient = scene.instantiate()
		Global.frier_used += 1
		print(Global.frier_used)
		add_child(sliced_ingredient)
		sliced_ingredient.position = %friesPosition.position
		ingredient.queue_free()
	else:
		pass

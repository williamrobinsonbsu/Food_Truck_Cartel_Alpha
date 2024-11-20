extends StaticBody3D

var scene = preload("res://ingredients/boxed_fries.tscn")
var fries_cooked = false

func use(ingredient):
	if ingredient.has_method("slice_name") and ingredient.slice_name() == "fries":
		$Fries.show()
		$AnimationPlayer.play("in")
		Global.frier_used += 1
		ingredient.audio_play_grill()
		ingredient.queue_free()
		await get_tree().create_timer(3).timeout
		$AnimationPlayer.play("out")
		fries_cooked = true
	
	if ingredient == null and fries_cooked == true:
		$Fries.hide()
		var fries = scene.instantiate()
		add_child(fries)
		fries.position = $Marker3D.position
		fries_cooked = false
		

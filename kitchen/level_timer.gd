extends Timer

func _on_root_scene_timer():
	var time := 300
	var timeText
	while time != 0:
		time -= 1
		timeText = str(time)
		$"../../Player/Control/LevelTimerLabel".text = timeText
		await get_tree().create_timer(1).timeout
	

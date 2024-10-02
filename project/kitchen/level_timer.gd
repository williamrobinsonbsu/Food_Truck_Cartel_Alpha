extends Timer

func _process(_delta):
	$"../../Player/Control/LevelTimerLabel".text = str(int(self.get_time_left()))
	

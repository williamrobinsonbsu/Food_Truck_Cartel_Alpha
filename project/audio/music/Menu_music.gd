extends AudioStreamPlayer


func play_music():
	if stream_paused == true:
		play()
	else:
		play(0.0)
func play_music_level():
	play_music()

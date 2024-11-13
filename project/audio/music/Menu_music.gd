extends AudioStreamPlayer

const level_music = preload("res://audio/music/East-West-John-Patitucci.ogg")

func play_music(music: AudioStream):
	if stream == music:
		return
	stream = music
	play()
func play_music_level():
	play_music(level_music)

extends AudioStreamPlayer


const level_music = preload("res://Modules/Assets/music/BaldoThemeSong.wav")
const menu_music = preload("res://Modules/Assets/music/BalloonDogThemeMenu.wav")



func _play_music(music: AudioStream, volume = 0.0):
	# If music is currently playing do nothing
	if stream == music:
		return
	
	# Set the song
	stream = music
	# Volume
	volume_db = volume
	play()


func play_music_level():
	_play_music(level_music)

func play_music_menu():
	_play_music(menu_music)

func _stop_music():
	stream = null

func _on_finished():
	play()

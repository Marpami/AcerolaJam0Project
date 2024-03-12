extends AudioStreamPlayer


# Sounds
const move_side = preload("res://Modules/Assets/sfx/MoveSide.wav")
const move_down = preload("res://Modules/Assets/sfx/Down.wav")
const game_over = preload("res://Modules/Assets/sfx/GameOver.wav")
const balloon_pop = preload("res://Modules/Assets/sfx/BalloonPop.wav")

const victory = preload("res://Modules/Assets/music/BaldoVictory.wav")


func _play_music(sfx: AudioStream, volume = 0.0):
	# Set the song
	stream = sfx
	# Volume
	volume_db = volume
	play()




func _move_side_play():
	stream = null
	_play_music(move_side)

func _move_down_play():
	stream = null
	_play_music(move_down)

func _balloon_pop_play():
	stream = null
	_play_music(balloon_pop)

func _game_over_play():
	stream = null
	_play_music(game_over)

func _victory():
	stream = null
	_play_music(victory)

# When done playing the audio empty the stream
func _on_finished():
	stream = null

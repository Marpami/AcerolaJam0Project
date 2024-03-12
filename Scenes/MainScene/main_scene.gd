extends Node2D

@onready var game_over_screen = $CanvasLayer/GameOverContainer
@onready var victory_screen = $CanvasLayer/VictoryContainer
@onready var timer_label = $CanvasLayer/TimerContainer/TimerLabel
@onready var timer_victory_label = $CanvasLayer/VictoryContainer/Margin/VBoxContainer/VictoryTimeLabel

@onready var sfx_player = $SfxPlayer


var game_over : bool = false

# Variables for timer below
var game_start_time: int = Time.get_ticks_msec()
var started_timer : bool = false

var s_min
var s_sec
var s_ms



func _ready():
	victory_screen.visible = false
	# Game starts by being paused, so player has the time to get ready
	get_tree().paused = true
	# Start the music
	AudioPlayer.play_music_level()
	game_over = false
	GlobalVar.is_dog_flying = true
	GlobalVar.is_dead = false
	game_over_screen.visible = false


func _process(_delta):
	# Because the game is paused at the start the timer won't run until its unpaused
	if started_timer == false:
		started_timer = true
		start_timer()
	
	if GlobalVar.is_dead == true:
		game_over_screen.visible = true
	
	if game_over == true:
		return
	
	if GlobalVar.is_dog_flying == false:
		game_over = true
		print("Game over")
	
	var the_time = time()
	timer_label.text = the_time
	timer_victory_label.text = "Time: " + the_time



func start_timer():
	started_timer = true
	game_start_time = Time.get_ticks_msec()


func time():
	# This will convert time in correct form
	var current_time = Time.get_ticks_msec() - game_start_time
	var minutes = current_time/1000/60
	var seconds = current_time/1000%60
	var msec = current_time%1000/10
	
	s_min = minutes
	s_sec = seconds
	s_ms = msec
	
	# Make sure the timer is 00:00:00
	if minutes < 10:
		minutes = "0" + str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
	if msec < 10:
		if msec == 0:
			msec = "00"
		else:
			msec = "0" + str(msec)
	
	return str(minutes) + ":" + str(seconds) + ":" + str(msec)





# ---------------------------
# Buttons below
# ---------------------------
func _on_play_again_button_button_down():
	get_tree().reload_current_scene()


func _on_main_menu_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")


# Body entered area
func _on_victory_area_body_entered(body):
	# If balloon has popped then you cannot win
	if GlobalVar.is_dog_flying == false:
		return
	if body.name == "Dog":
		print("Victory")
		AudioPlayer._stop_music()
		sfx_player._victory()
		victory_screen.visible = true
		get_tree().paused = true

# more Buttons
func _on_play_button_button_down():
	get_tree().reload_current_scene()


func _on_menu_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")

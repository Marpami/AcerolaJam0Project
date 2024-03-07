extends Control


@onready var menu = $MarginContainer/Menu
@onready var settings = $MarginContainer/Settings


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	AudioPlayer.play_music_menu()
	menu.visible = true
	settings.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/MainScene/main_scene.tscn")


func _on_settings_button_button_down():
	menu.visible = false
	settings.visible = true


func _on_exit_button_button_down():
	get_tree().quit()



func _on_back_button_button_down():
	menu.visible = true
	settings.visible = false

extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/MainScene/main_scene.tscn")


func _on_settings_button_button_down():
	pass # Replace with function body.


func _on_exit_button_button_down():
	get_tree().quit()

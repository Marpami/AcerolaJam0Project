extends Node2D


# This will be spawned
var water_drop = preload("res://Scenes/WaterDropSpawner/water_drop.tscn")

const min_wait : float = 0.5
const max_wait : float = 5

var is_on_screen : bool = false


func _ready():
	# Just a debug if fore some reason its missing
	if water_drop == null:
		printerr("Water Drop Spawner: Missing water drop")
		return


func _spawn_drop():
	var water = water_drop.instantiate()
	add_child(water)
	_wait()


func _wait():
	
	var rng = RandomNumberGenerator.new()
	var wait_time = rng.randf_range(min_wait, max_wait)
	print("Wait: ", wait_time)
	await get_tree().create_timer(wait_time).timeout
	
	# If not on screen then don't spawn
	if is_on_screen == false:
		return
	
	# Prevents spawning in water drops while the game is paused
	if get_tree().paused == true:
		_wait()
		return
	
	_spawn_drop()


# When on screen spawn water drops
func _on_visible_on_screen_enabler_2d_screen_entered():
	is_on_screen = true
	_wait()

# Else don't
func _on_visible_on_screen_enabler_2d_screen_exited():
	is_on_screen = false

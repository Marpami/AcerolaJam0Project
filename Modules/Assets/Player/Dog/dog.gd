extends RigidBody2D


@export var sfx_player : AudioStreamPlayer
@onready var anim = $AnimatedSprite2D

var wait_time_move : float = 0.5
var waiting : bool = false

# DOWN
const down_speed : int = 60
# LEFT
const counter_left : int = 30
const left_speed : int = -55
# RIGHT
const counter_right : int = -30
const right_speed : int = 55

var death_anim : bool = false

const spike_name = "SpikeMap"

var balloon_popped : bool = false
var played_death : bool = false



func _process(delta):
	# Checks when player is not flying aka balloon pops
	if GlobalVar.is_dog_flying == false:
		if balloon_popped == false:
			balloon_popped = true
			sfx_player._balloon_pop_play()
		
		if GlobalVar.is_dead == false:
			anim.play("fall")


func _input(event):
	# If game is over then prevent further movement
	if GlobalVar.is_dog_flying == false:
		return
	if GlobalVar.is_dead == true:
		return
	
	# Wait for the movement cooldown to go down
	if waiting == true:
		return
	# Movement
	if event.is_action_pressed("down"):
		anim.play("down")
		sfx_player._move_down_play()
		waiting = true
		movement_timer()
		linear_velocity = Vector2(0, down_speed)
		
	if event.is_action_pressed("left"):
		# If not facing this way then flip
		if anim.flip_h == false:
			anim.flip_h = true
		
		waiting = true
		linear_velocity = Vector2(counter_left, 0)
		# Play the animation
		anim.play("move_counter")
		# Play the sound
		sfx_player._move_side_play()
		await get_tree().create_timer(0.3).timeout
		anim.play("move")
		linear_velocity = Vector2(left_speed, 0)
		movement_timer()
		
	if event.is_action_pressed("right"):
		# If not facing this way then flip
		if anim.flip_h == true:
			anim.flip_h = false
		
		waiting = true
		linear_velocity = Vector2(counter_right, 0)
		anim.play("move_counter")
		# Play the sound
		sfx_player._move_side_play()
		
		await get_tree().create_timer(0.3).timeout
		
		anim.play("move")
		linear_velocity = Vector2(right_speed, 0)
		movement_timer()


func movement_timer():
	await get_tree().create_timer(wait_time_move).timeout
	waiting = false
	# Don't do idle if the dog is not flying anymore
	if GlobalVar.is_dog_flying == false:
		return
	if GlobalVar.is_dead == true:
		return
	anim.play("idle")





func _on_body_entered(body):
	# Prevent happening twice
	if 	played_death == true:
		return
	
	# If the body we hit is spike then player plays death animation
	if body.name == spike_name:
		played_death = true
		print("Death by spikes")
		GlobalVar.is_dead = true
		sfx_player._game_over_play()
		anim.play("death")
	
	
	# If the dog is not flying and hits the ground play death animation
	if GlobalVar.is_dog_flying == false:
		played_death = true
		GlobalVar.is_dead = true
		sfx_player._game_over_play()
		anim.play("death")




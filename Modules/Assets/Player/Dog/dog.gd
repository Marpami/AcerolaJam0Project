extends RigidBody2D





var wait_time_move : float = 0.5
var waiting : bool = false
var can_move : bool = true
var on_ground : bool = false







func _input(event):
	# Wait for the movement cooldown to go down
	if waiting == true:
		return
	# Movement
	if event.is_action_pressed("down"):
		waiting = true
		movement_timer()
		linear_velocity = Vector2(0, 60)
		
	if event.is_action_pressed("left"):
		waiting = true
		linear_velocity = Vector2(30, 0)
		await get_tree().create_timer(0.3).timeout
		linear_velocity = Vector2(-50, 0)
		movement_timer()
		
	if event.is_action_pressed("right"):
		waiting = true
		linear_velocity = Vector2(-30, 0)
		await get_tree().create_timer(0.3).timeout
		linear_velocity = Vector2(50, 0)
		movement_timer()


func movement_timer():
	await get_tree().create_timer(wait_time_move).timeout
	waiting = false




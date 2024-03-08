extends RigidBody2D


# Destroy on contact with anything
func _on_body_entered(body):
	print("Destroy")
	queue_free()

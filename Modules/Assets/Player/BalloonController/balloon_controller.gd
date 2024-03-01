extends RigidBody2D




func _on_body_entered(body):
	print("Body: ", body)
	GlobalVar.is_dog_flying = false
	self.queue_free()
	

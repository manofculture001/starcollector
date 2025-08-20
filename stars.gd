extends Area2D
signal collected(star)

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("collected", self)
		queue_free()

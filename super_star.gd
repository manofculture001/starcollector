extends Area2D
@export var bonus_time := 5
signal collected_superstar

func _on_body_entered(body):
	if body.name == "Player":
		get_parent().apply_time_bonus(bonus_time)
		emit_signal("collected_superstar")
		queue_free()

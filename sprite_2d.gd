extends Area2D

@export var speed := 200
@export var direction := Vector2(1,0)
@export var penalty_time := 3

func _physics_process(delta):
	position += direction * speed * delta
	if position.x < 0 or position.x > 1280:
		direction.x *= -1
	if position.y < 0 or position.y > 720:
		direction.y *= -1

func _on_body_entered(body):
	if body.name == "Player":
		get_parent().apply_time_penalty(penalty_time)
		body.apply_knockback(global_position)

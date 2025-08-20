extends CharacterBody2D

@export var speed := 400
@export var knockback_strength := 300

var velocity := Vector2.ZERO

func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if Input.get_touch_count() > 0:
		var touch_pos = Input.get_touch_position(0)
		velocity = (touch_pos - global_position).normalized()

	velocity = velocity.normalized() * speed
	move_and_slide(velocity)

func apply_knockback(from_position: Vector2):
	var direction = (global_position - from_position).normalized()
	move_and_slide(direction * knockback_strength)

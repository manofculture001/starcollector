extends Node2D

@onready var timer_label = $UI/TimerLabel
@onready var stars_label = $UI/StarsCollectedLabel
@onready var message_label = $UI/MessageLabel

@export var total_stars := 7
@export var time_limit := 60
var time_left := time_limit
var stars_collected := 0

func _ready():
	for star in $Stars.get_children():
		star.connect("collected", Callable(self, "_on_star_collected"))
	if $SuperStar:
		$SuperStar.connect("collected_superstar", Callable(self, "_on_superstar_collected"))

func _process(delta):
	time_left -= delta
	timer_label.text = "Time: %.1f" % time_left
	stars_label.text = "Stars: %d/%d" % [stars_collected, total_stars]
	_update_message_label()
	if time_left <= 0:
		_game_over()

func _on_star_collected(star):
	stars_collected += 1
	if stars_collected == total_stars:
		_win_game()

func _on_superstar_collected():
	pass

func apply_time_penalty(seconds):
	time_left = max(time_left - seconds, 0)

func apply_time_bonus(seconds):
	time_left += seconds

func _update_message_label():
	if time_left > 40:
		message_label.text = "Go! Collect the stars!"
	elif time_left > 20:
		message_label.text = "Keep going, time is ticking!"
	else:
		message_label.text = "Hurry! Almost out of time!"

func _game_over():
	message_label.text = "Time's up! 💔"
	get_tree().paused = true

func _win_game():
	message_label.text = "All stars collected! 💖"
	_spawn_heart_constellation()
	get_tree().paused = true

func _spawn_heart_constellation():
	var center = Vector2(640, 360)
	var radius = 100
	for i in range(total_stars):
		var star = Sprite2D.new()
		star.texture = preload("res://assets/star_glow.png")
		var angle = PI/4 + i * (PI/2 / (total_stars-1))
		star.position = center + Vector2(cos(angle), -sin(angle)) * radius
		add_child(star)
	var note = Label.new()
	note.text = "You collected the stars of my heart! ❤️"
	note.position = Vector2(400, 600)
	add_child(note)

extends Control

@export var player : Node2D
@export var progress_bar : ProgressBar

var start_x
var end_x
var speed = 250.0 
var velocity = 0.0
var friction = 5
var acceleration = 5

var is_fake_loading = false
var fake_progress = 0

func _ready():
	await get_tree().process_frame
	var bar_rect = progress_bar.get_global_rect()
	start_x = bar_rect.position.x
	end_x = bar_rect.position.x + bar_rect.size.x

	print(str(start_x) + " " + str(end_x))
	
	fake_progress = 0.0
	progress_bar.value = 0.0
	is_fake_loading = true
	
	player.position.x = start_x
	player.position.y = bar_rect.position.y - 100

func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity = lerp(velocity, direction * speed, acceleration * delta)
	else:
		velocity = lerp(velocity, 0.0, friction * delta)
	
	if is_fake_loading:
		fake_progress += 7 * delta 
		if fake_progress >= 21.0:
			fake_progress = 21.0
			is_fake_loading = false  
		progress_bar.value = fake_progress
		player.position.x = start_x + (fake_progress / 100) * (end_x - start_x)
	else:
		player.position.x += velocity * delta
		player.position.x = clamp(player.position.x, start_x, end_x)
		
		var progress = (player.position.x - start_x) / (end_x - start_x)
		progress = clamp(progress, 0.0, 1.0)
		progress_bar.value = progress * 100.0
	
	if progress_bar.value >= 95:
		TransitionManager.transition_to("res://Levels/level2.tscn")

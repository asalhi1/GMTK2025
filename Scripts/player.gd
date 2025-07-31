extends CharacterBody2D

@export var gravity := 1200.0
@export var speed := 400.0
@export var min_x := 280.0
@export var max_x := 800.0

func _physics_process(delta):
	velocity.y += gravity * delta

	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

	move_and_slide()

	global_position.x = clamp(global_position.x, min_x, max_x)

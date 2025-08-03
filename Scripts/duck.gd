extends Area2D

@export var speed : int
var was_shot := false
signal duck_shot

func _physics_process(delta: float) -> void:
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x + 50:
		position.x = -50  # Wrap around to left

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and not was_shot:
		was_shot = true
		$CPUParticles2D.emitting = true
		$AnimatedSprite2D.play("fall")
		duck_shot.emit()
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(5).timeout
		queue_free()

extends Area2D

@export var speed : int
var was_shot := false
signal duck_shot

func _physics_process(delta: float) -> void:
	if was_shot:
		return
	position.x += speed * delta
	if position.x > get_viewport_rect().size.x + 50:
		position.x = -50  # Wrap around to left

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		was_shot = true
		hide()
		duck_shot.emit()
		queue_free()

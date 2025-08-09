extends Label

@export var time_before_hint := 10.0
var _timer := 0.0

func _process(delta):
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		return
	
	_timer += delta
	
	if _timer >= time_before_hint:
		text = "Use ARROW KEYS to move"

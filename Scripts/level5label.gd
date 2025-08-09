extends Label

@export var time_before_hint := 20.0
var _timer := 0.0

func _process(delta):
	_timer += delta
	
	if _timer >= time_before_hint:
		text = "Tip: Try sorting the statues."

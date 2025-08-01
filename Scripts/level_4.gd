extends Control

@export var duck_scene : PackedScene
@export var crosshair_scene : PackedScene
@export var duck_container : Node
@export var progress_bar : ProgressBar

var total_ducks := 10
var ducks_shot := 0
var crosshair

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	crosshair = crosshair_scene.instantiate()
	add_child(crosshair)
	for i in total_ducks:
		var duck = duck_scene.instantiate()
		duck.position = Vector2(-i * 125 + 1000, -50) 
		duck_container.add_child(duck)
		duck.duck_shot.connect(_on_duck_shot)

func _process(delta: float) -> void:
	crosshair.global_position = get_viewport().get_mouse_position()

func _on_duck_shot():
	ducks_shot += 1
	var t = create_tween()
	t.set_trans(Tween.TRANS_CUBIC)
	t.set_ease(Tween.EASE_IN_OUT)
	t.tween_property(progress_bar, "value", float(ducks_shot) / total_ducks * 100.0, .5)
	#progress_bar.value = float(ducks_shot) / total_ducks * 100.0
	if ducks_shot == total_ducks:
		print("Loading complete!")

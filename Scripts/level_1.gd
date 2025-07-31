extends Node2D

@onready var player := $Player
@onready var progress_bar := $ProgressBar

@export var start_x : float = 280.0
@export var end_x : float = 800.0

func _ready() -> void:
	player.global_position.x = 280.0

func _process(delta: float) -> void:
	var player_x : float = clamp(player.global_position.x, start_x, end_x)

	var t : float = (player_x - start_x) / (end_x - start_x)
	progress_bar.value = lerp(progress_bar.min_value, progress_bar.max_value, t)

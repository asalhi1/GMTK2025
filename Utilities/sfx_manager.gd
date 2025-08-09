extends Node

@export var audio_player: AudioStreamPlayer
@export var sfx_streams: Dictionary

var min_pitch = 0.9
var max_pitch = 1.1

func _ready()->void:
	var buttons : Array = get_tree().get_nodes_in_group("Button")
	for inst in buttons:
		inst.connect("pressed", on_button_pressed)

func on_button_pressed()->void:
	play_sfx("click")

func play_sfx(sfx_name: String):
	if not sfx_streams.has(sfx_name):
		return

	if sfx_name == "glitch":
		$AudioStreamPlayer.pitch_scale = randf_range(min_pitch, max_pitch)
	else:
		$AudioStreamPlayer.pitch_scale = 1.0
	
	var new_stream = sfx_streams[sfx_name]
	audio_player.stream = new_stream
	audio_player.play()

func stop_sfx():
	audio_player.stop()

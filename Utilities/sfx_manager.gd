extends Node

@export var audio_player: AudioStreamPlayer
@export var sfx_streams: Dictionary

func _ready()->void:
	var buttons : Array = get_tree().get_nodes_in_group("Button")
	for inst in buttons:
		inst.connect("pressed", on_button_pressed)

func on_button_pressed()->void:
	play_sfx("click")

func play_sfx(sfx_name: String):
	if not sfx_streams.has(sfx_name):
		return

	var new_stream = sfx_streams[sfx_name]
	audio_player.stream = new_stream
	audio_player.play()

func stop_sfx():
	audio_player.stop()

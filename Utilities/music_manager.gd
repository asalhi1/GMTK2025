extends Node

@export var audio_player: AudioStreamPlayer
@export var level_music_streams: Dictionary

var current_level := ""
var current_time := 0.0

func play_music_for_level(level_name: String):
	if not level_music_streams.has(level_name):
		return

	current_time = audio_player.get_playback_position()

	var new_stream = level_music_streams[level_name]
	audio_player.stream = new_stream
	audio_player.play(current_time)

	current_level = level_name

func stop_music():
	audio_player.stop()
	current_time = 0.0
	current_level = ""

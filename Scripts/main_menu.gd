extends Control

func _ready() -> void:
	MusicManager.play_music_for_level("variant1")

func _on_start_pressed() -> void:
	TransitionManager.transition_to("res://Levels/level1.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/options.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/credits.tscn")

extends Control

func _ready() -> void:
	MusicManager.play_music_for_level("variant1")

func _on_start_pressed() -> void:
	TransitionManager.transition_to("res://Levels/level1.tscn")

func _on_options_pressed() -> void:
	pass # Replace with function body.
	

func _on_credits_pressed() -> void:
	pass # Replace with function body.

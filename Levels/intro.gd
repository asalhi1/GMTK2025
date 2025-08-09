extends Control

func _ready():
	MusicManager.audio_player.volume_db = -10.0
	SfxManager.audio_player.volume_db = -10.0

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	TransitionManager.transition_to("res://Levels/main_menu.tscn")

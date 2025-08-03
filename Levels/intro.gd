extends Control

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	TransitionManager.transition_to("res://Levels/main_menu.tscn")

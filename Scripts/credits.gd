extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")

extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SfxManager.play_sfx("windowserror")
	MusicManager.stop_music()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")

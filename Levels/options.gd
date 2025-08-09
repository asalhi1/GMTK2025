extends Control

@export var music_slider: Slider
@export var sfx_slider: Slider

func _ready():
	music_slider.value = db_to_linear(clamp(MusicManager.audio_player.volume_db, -80.0, -10.0))
	sfx_slider.value = db_to_linear(clamp(SfxManager.audio_player.volume_db, -80.0, -10.0))

	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)

func _on_music_slider_changed(value: float) -> void:
	MusicManager.audio_player.volume_db = linear_to_db(clamp(value, 0.001, 1.0))

func _on_sfx_slider_changed(value: float) -> void:
	SfxManager.audio_player.volume_db = linear_to_db(clamp(value, 0.001, 1.0))

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")

extends CanvasLayer

@onready var overlay = $ColorRect
@onready var animation_player = $AnimationPlayer

var target_scene_path : String

func transition_to(scene_path: String):
	target_scene_path = scene_path
	animation_player.play("glitch_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "glitch_out":
		get_tree().change_scene_to_file(target_scene_path)
		animation_player.play("glitch_in")

extends CanvasLayer

@export var transition_glitch : Node
@export var animation_player : Node

var target_scene_path := ""
var transitioning := false

func transition_to(scene_path: String):
	if transitioning:
		return
	transitioning = true
	target_scene_path = scene_path

	var mat := transition_glitch.material as ShaderMaterial
	mat.set_shader_parameter("shake_rate", 0.4)
	mat.set_shader_parameter("shake_power", 0.06)
	mat.set_shader_parameter("shake_color_rate", 0.02)
	mat.set_shader_parameter("shake_speed", 10.0)

	animation_player.play("glitch_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "glitch_out":
		get_tree().change_scene_to_file(target_scene_path)
		animation_player.play("glitch_in")
		await animation_player.animation_finished
		var mat := transition_glitch.material as ShaderMaterial
		mat.set_shader_parameter("shake_rate", 0)
		mat.set_shader_parameter("shake_power", 0)
		mat.set_shader_parameter("shake_color_rate", 0)
		mat.set_shader_parameter("shake_speed", 0)
	elif anim_name == "glitch_in":
		# AmbientGlitch.increase_glitch_level()
		transitioning = false

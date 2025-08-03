extends CanvasLayer

@export var glitch_rect : ColorRect

var glitch_level : float = 0

func _ready():
	update_glitch_intensity()

func increase_glitch_level():
	glitch_level += .5
	update_glitch_intensity()

func set_glitch_level(level: float):
	glitch_level = level
	update_glitch_intensity()

func update_glitch_intensity():
	var mat := glitch_rect.material as ShaderMaterial
	if mat == null:
		print("ShaderMaterial not found!")
		return

	mat.set_shader_parameter("shake_rate", clamp(0.015 * glitch_level, 0.0, 1.0))
	mat.set_shader_parameter("shake_power", clamp(0.0023 * glitch_level, 0.0, 0.2))
	mat.set_shader_parameter("shake_color_rate", clamp(0.00125 * glitch_level, 0.0, 0.1))
	mat.set_shader_parameter("shake_speed", clamp(.5 * glitch_level, 0.0, 50.0))

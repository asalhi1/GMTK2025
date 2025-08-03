extends TextureRect

@export var statue_height: int = 0
@export var parent : Node

var drag_preview = null

func _ready():
	set_drag_forwarding(get_drag_data, can_drop_data, drop_data)

func get_drag_data(position):
	var drag_data = {
		"texture": texture,
		"height": statue_height,
		"source": self
	}

	# Create drag preview
	drag_preview = TextureRect.new()
	drag_preview.texture = texture
	drag_preview.expand = true
	drag_preview.stretch_mode = STRETCH_KEEP_ASPECT_CENTERED
	drag_preview.modulate = Color(1, 1, 1, 0.8) # slight transparency

	set_drag_preview(drag_preview)

	# Visual feedback on original
	modulate = Color(1, 1, 1, 0.3)  # fade the original

	return drag_data


func can_drop_data(position, data):
	return typeof(data) == TYPE_DICTIONARY and data.has("texture") and data.has("source")

func drop_data(position, data):
	if not can_drop_data(position, data): return

	var source = data["source"]
	if source == self: return

	# Reset visuals
	modulate = Color(1, 1, 1, 1)
	source.modulate = Color(1, 1, 1, 1)

	# Swap textures and heights
	var temp_texture = texture
	var temp_height = statue_height

	texture = data["texture"]
	statue_height = data["height"]

	source.texture = temp_texture
	source.statue_height = temp_height

	if parent.is_correct_order():
		AmbientGlitch.set_glitch_level(3)
		TransitionManager.transition_to("res://Levels/Level4/level4.tscn")

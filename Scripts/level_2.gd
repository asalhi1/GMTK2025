extends Control

@export var captcha_ui : Node
@export var captcha_button_container : Node
@export var captcha_button : Node
@export var captcha_label : Label
@export var captcha_grid : Node

@export var loading_bar : ProgressBar 
@export var loading_label : Label

var captcha_solutions = [
	[0, 3, 7],
	[2, 4, 8],
	[1, 5, 6]
]
var captcha_text = [
	"Select all images with a car",
	"Select all images with a fire hydrant",
	"Select all images with a crosswalk"
]
var current_captcha = 0
var selected_cells = []

func _ready():
	captcha_ui.visible = false
	captcha_button_container.visible = false
	start_loading()

func start_loading():
	loading_bar.value = 0
	await get_tree().create_timer(1).timeout
	while loading_bar.value < 31:
		loading_bar.value += 1
		await get_tree().create_timer(0.05).timeout
	
	captcha_label.text = "Please complete CAPTCHA to continue."
	captcha_button_container.visible = true

func show_captcha(index):
	selected_cells.clear()
	captcha_label.text += "\n" + captcha_text[index]
	var container = captcha_grid
	for i in range(container.get_child_count()):
		var btn = container.get_child(i)
		btn.set_pressed(false)
		if btn.is_connected("pressed", _on_captcha_cell_pressed):
			btn.disconnect("pressed", Callable(self, "_on_captcha_cell_pressed").bind(i))
		btn.connect("pressed", Callable(self, "_on_captcha_cell_pressed").bind(i))
		# Set texture to captcha image (can be faked with colors)
		# btn.texture_normal = preload("res://captcha%d_tile%d.png" % [index, i])

func _on_captcha_cell_pressed(index):
	if selected_cells.has(index):
		selected_cells.erase(index)
	else:
		selected_cells.append(index)
	
	print(selected_cells)

func complete_loading():
	captcha_ui.visible = false
	captcha_label.text = "Verification successful. Loading..."
	while loading_bar.value < 100:
		loading_bar.value += 1
		await get_tree().create_timer(0.03).timeout
	TransitionManager.transition_to("res://Levels/level3.tscn")

func _on_captcha_button_pressed() -> void:
	captcha_ui.visible = true
	captcha_button_container.visible = false
	show_captcha(current_captcha)
	
func _on_verify_pressed() -> void:
	selected_cells.sort()
	if selected_cells == captcha_solutions[current_captcha]:
		complete_loading()
	else:
		current_captcha = (current_captcha + 1) % 3
		captcha_label.text = "Incorrect. Try another CAPTCHA."
		await get_tree().create_timer(0.5).timeout
		show_captcha(current_captcha)

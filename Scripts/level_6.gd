extends Control

@export var accept_button : Button
@export var decline_button : Button
@export var label : Label
@export var bar : ProgressBar
@export var terms_container : Node

var curr_accept = 0
var finishing_loading = false

var msgs = [
	"Make sure you read through all the terms before clicking accept.",
	"Make sure you READ through ALL the terms before clicking accept. Seriously, ALL of them.",
	"Make sure you COMPREHEND ALL THE TERMS before clicking accept.",
	"Are you 100% sure?",
	"You don't understand what you're getting yourself into.",
	"Dude just decline..."
]

func _ready():
	MusicManager.play_music_for_level("variant1")
	accept_button.pressed.connect(_on_accept_pressed)
	decline_button.pressed.connect(_on_decline_pressed)

func _process(delta):
	if bar.value < 69:
		bar.value += 50 * delta
	else:
		terms_container.visible = true

func _on_accept_pressed():
	curr_accept = min(curr_accept + 1, msgs.size() - 1)
	label.text = msgs[curr_accept]

func _on_decline_pressed():
	finishing_loading = true
	TransitionManager.transition_to("res://Levels/level2.tscn")

extends LineEdit

@export var history : TextEdit
@export var loading_bar : ProgressBar
@export var error_label : Label
@export var terminal : Node
@export var typing_space : Node

var typing_timer : Timer

func _ready():
	MusicManager.play_music_for_level("8bit")
	grab_focus()
	connect("text_submitted", Callable(self, "_on_command_entered"))

	typing_timer = Timer.new()
	typing_timer.timeout.connect(stop_typing)
	typing_timer.one_shot = true
	typing_timer.wait_time = 0.25
	add_child(typing_timer)

	var t = create_tween()
	t.set_trans(Tween.TRANS_EXPO)
	t.tween_property(loading_bar, "value", 74, 2.5)
	await t.finished
	terminal.visible = true

func _on_command_entered(command: String):
	SfxManager.play_sfx("enter_command")
	command = command.strip_edges()
	history.text += "\n> " + command

	match command:
		"reboot":
			error_label.text = "System recovery in progress..."
			loading_bar.value = 100
			history.text += "\nResuming loading sequence..."
			await get_tree().create_timer(1.0).timeout
			TransitionManager.transition_to("res://Levels/level5.tscn")
		"help":
			history.text += "\nAvailable commands:\n - status\n - launch_missiles\n - make_coffee\n - reboot\n - help\n - clear"
		"status":
			history.text += "\nLoading process is frozen at 74%.\nPossible cause: Unknown Error"
		"launch_missiles":
			history.text += "\nPermission denied: Global Thermonuclear War is not supported in demo mode."
		"make_coffee":
			history.text += "\nError: No coffee module found. Install 'beverage-dlc' to continue."
		"clear":
			history.text = ""
		_:
			error_label.text = "Unknown command. Try again."
			history.text += "\nUnknown command: '" + command + "'"

	text = ""
	history.scroll_vertical = history.get_line_count()
	typing_space.call_deferred("grab_focus")

func _gui_input(event):
	if event is InputEventKey and event.pressed and !event.echo:
		if not SfxManager.audio_player.playing:
			SfxManager.play_sfx("typing")
		typing_timer.start()

func stop_typing():
	SfxManager.stop_sfx()

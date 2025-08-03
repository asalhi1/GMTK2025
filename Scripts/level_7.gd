extends Control

@onready var hour_input = $ClockUI/ClockContainer/HourInput
@onready var minute_input = $ClockUI/ClockContainer/MinuteInput
@onready var second_input = $ClockUI/ClockContainer/SecondInput
@onready var tick_timer = $TickTimer
@onready var count_down = $CountDown
@onready var load_timer = $LoadTimer
@onready var progress_bar = $ClockUI/ProgressBar
@onready var clock_container = $ClockUI/ClockContainer
@onready var label = $Label

var loading_phase = 1

func _ready():
	progress_bar.value = 0
	clock_container.visible = false
	count_down.visible = false
	label.visible = false
	tick_timer.connect("timeout", _on_tick_timer_timeout)
	load_timer.connect("timeout", _on_load_timer_timeout)

func _on_load_timer_timeout():
	if loading_phase == 1:
		if progress_bar.value < 90:
			progress_bar.value += 1
		else:
			loading_phase = 0
			load_timer.stop()
			_start_clock_phase()
	elif loading_phase == 2:
		if progress_bar.value < 100:
			progress_bar.value += 1
		else:
			load_timer.stop()

func _start_clock_phase():
	hour_input.text = "99"
	minute_input.text = "59"
	second_input.text = "10" 
	label.visible = true
	clock_container.visible = true
	count_down.visible = true
	tick_timer.start()

func _on_tick_timer_timeout():
	var h = int(hour_input.text)
	var m = int(minute_input.text)
	var s = int(second_input.text)

	if h == 0 and m == 0 and s == 0:
		label.visible = false
		tick_timer.stop()
		count_down.text = "We're almost done..."
		count_down.visible = true
		loading_phase = 2
		load_timer.start()
		return

	if s > 0:
		s -= 1
	elif m > 0:
		m -= 1
		s = 20
	elif h > 0:
		h -= 1
		m = 59
		s = 20

	hour_input.text = str(h).pad_zeros(2)
	minute_input.text = str(m).pad_zeros(2)
	second_input.text = str(s).pad_zeros(2)

	if h == 0 and m == 0:
		label.visible = false
		var message = "Great! Only " + str(s) + " second"
		if s != 0:
			message += "s"
			count_down.text = message
			count_down.visible = true
		else:
			count_down.text = ""

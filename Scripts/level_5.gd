extends Control

@export var hbox_container : Node

func _ready():
	MusicManager.play_music_for_level("variant2")

func is_correct_order() -> bool:
	for i in range(hbox_container.get_child_count() - 1):
		var curr = hbox_container.get_child(i)
		var next = hbox_container.get_child(i + 1)
		if curr.statue_height > next.statue_height:
			return false
	return true

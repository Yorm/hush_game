extends Control

onready var dialogBackground = $TextureRect
onready var dialogEnd = $TextureRect/DialogEnd
onready var dialogText = $TextureRect/Dialog/DialogText

export var typing_speed = 0.05
export var read_time = 1

var current_message = 0
var display = ""
var current_char = 0

var messages = [""]

func _ready():
	dialogText.text = ""
	hide_dialog()
	DialogStats.connect("show_dialog", self, "show_dialog")
	DialogStats.connect("hide_dialog", self, "hide_dialog")
	
func hide_dialog():
	current_message = 0
	display = ""
	current_char = 0
	dialogBackground.visible = false
	
func show_dialog(value):
	current_message = 0
	display = ""
	current_char = 0
	
	dialogBackground.visible = true
	dialogEnd.visible = false
	messages = value
	
	$TextureRect/Dialog/next_char.set_wait_time(typing_speed)
	$TextureRect/Dialog/next_char.start()

func _on_next_char_timeout():
	if current_char < len(messages[current_message]):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		dialogText.text = display
		current_char += 1
	else:
		$TextureRect/Dialog/next_char.stop()
		$TextureRect/Dialog/next_message.one_shot = true
		$TextureRect/Dialog/next_message.set_wait_time(read_time)
		$TextureRect/Dialog/next_message.start()

func _on_next_message_timeout():
	if current_message == len(messages) - 1:
		dialogEnd.visible = true
		DialogStats.in_dialog = false
	else:
		current_message += 1
		display = ""
		current_char = 0
		
		$TextureRect/Dialog/next_char.start()

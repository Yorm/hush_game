extends Node

var in_dialog = false
var is_showing = false setget set_show_dialog
var message = "" setget set_message

signal show_dialog(message)
signal hide_dialog

func set_show_dialog(value):
	is_showing = value
	if is_showing == true:
		in_dialog = true
		emit_signal("show_dialog", message)
	else:
		in_dialog = false
		emit_signal("hide_dialog")

func set_message(value):
	message = value

func _ready():
	self.is_showing = false
	self.message = ""
	self.in_dialog = false

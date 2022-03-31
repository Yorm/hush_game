extends Area2D

export var message = [""]

func _on_DialogArea_area_entered(area):
	DialogStats.set_message(message)
	#DialogStats.set_show_dialog(true)


func _on_DialogArea_area_exited(area):
	#DialogStats.set_message("")
	#DialogStats.set_show_dialog(false)
	pass

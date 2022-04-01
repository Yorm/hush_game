extends AnimatedSprite


func _ready():
	#к сожалению, подобное решение пока что скрывает все знаки на карте
	DialogStats.connect("show_dialog", self, "hide_sic")
	DialogStats.connect("hide_dialog", self, "show_sic")

	var time = rand_range(0.5,1)
	yield(get_tree().create_timer(time), "timeout")
	play("Animate")

func hide_sic(value):
	visible = false
	
func show_sic():
	visible = true

extends AnimatedSprite


onready var timer = $Timer

func _ready():
	var time = rand_range(0.5,1)
	yield(get_tree().create_timer(time), "timeout")
	play("Animate")

func _on_WaterLilSingle_frame_changed():
	var time = rand_range(0.5,0.1)
	stop()
	$Timer.start(time)

func _on_Timer_timeout():
	play("Animate")

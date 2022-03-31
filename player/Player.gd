extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 50
export var ROLL_SPEED = 100
export var FRICTION = 600

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var dialogArea = $DialogArea

enum {
	MOVE,
	DIALOG
}

var state = MOVE

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		DIALOG:
			dialog_state(delta)


func dialog_state(delta):
	if DialogStats.in_dialog == false && Input.is_action_just_pressed("start_dialog"):
		if state == DIALOG:
			dialogArea.end_dialog()
			state = MOVE

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
	input_vector.y = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()
	check_can_start_dialog()

func move():
	velocity = move_and_slide(velocity)
	

func check_can_start_dialog():
	if dialogArea.get_overlapping_areas().size() <= 0: # нужно потом чекать на перекрытие особыми area
		dialogArea.end_dialog()
	else:
		if DialogStats.in_dialog == false && Input.is_action_just_pressed("start_dialog"):
			if state == MOVE:
				dialogArea.start_dialog()
				state = DIALOG
				animationState.travel("Idle")

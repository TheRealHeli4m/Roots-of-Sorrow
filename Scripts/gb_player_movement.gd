extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
@onready var was_on_floor = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0
		
	was_on_floor = is_on_floor()
	move_and_slide()

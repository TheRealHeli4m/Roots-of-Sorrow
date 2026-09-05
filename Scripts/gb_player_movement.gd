extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -500.0
@onready var was_on_floor = true
@onready var canJump = true
@onready var animSprite = $AnimatedSprite2D
@onready var coyoteTimer = $CoyoteTimer
@onready var jBuffTimer = $JumpBufferingTimer

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		canJump = false
		
	if animSprite.animation == "landing":
		canJump = false
		
	if Input.is_action_just_pressed("jump") and not canJump:
		jBuffTimer.start()
	 
	if (Input.is_action_just_pressed("jump") or not jBuffTimer.is_stopped()) and (canJump or not coyoteTimer.is_stopped()):
		velocity.y = JUMP_VELOCITY
		
	if was_on_floor and not is_on_floor():
		coyoteTimer.start()
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0
		
	canJump = true
	was_on_floor = is_on_floor()
	move_and_slide()

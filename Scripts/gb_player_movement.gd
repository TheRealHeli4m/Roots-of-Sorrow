extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
@onready var was_on_floor = true
@onready var canJump = true
@onready var canMove = true
@onready var animSprite = $AnimatedSprite2D
@onready var coyoteTimer = $CoyoteTimer
@onready var jBuffTimer = $JumpBufferingTimer

func _physics_process(delta: float) -> void:
	if not is_on_floor(): # gravity
		velocity += get_gravity() * delta
		canJump = false
		if was_on_floor:
			coyoteTimer.start()
		
	if animSprite.animation == "landing": # stops jumping when landing animation is playing to prevent bug
		canJump = false
	 
	# if pressed jump or jump buffering is still running, and can jump and coyotetimer is still running
	if (Input.is_action_pressed("jump") or not jBuffTimer.is_stopped()) and (canJump or not coyoteTimer.is_stopped()):
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("jump") and not canJump:
		jBuffTimer.start()
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0
		
	canJump = true # reset canjump at the end of every frame
	was_on_floor = is_on_floor()
	if canMove:
		move_and_slide()

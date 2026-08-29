extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("move_left"):
		animatedSprite.flip_h = true
		animatedSprite.play("run")
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		animatedSprite.flip_h = false
		animatedSprite.play("run")
		velocity.x = SPEED
	else:
		animatedSprite.play("idle")
		velocity.x = 0

	move_and_slide()

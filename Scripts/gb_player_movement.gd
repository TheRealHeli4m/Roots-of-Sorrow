extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D
@onready var was_on_floor = true
@onready var is_jumping = false
const SPEED = 500.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	if not was_on_floor and is_on_floor():
		animatedSprite.play("landing")
		is_jumping = false
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		animatedSprite.play("charge_jump")
		await animatedSprite.animation_finished
		velocity.y = JUMP_VELOCITY
		animatedSprite.play("jump")
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0

	if not is_jumping:
		if Input.is_action_pressed("move_left"):
			animatedSprite.play("run")
			animatedSprite.flip_h = true
		elif Input.is_action_pressed("move_right"):
			animatedSprite.play("run")
			animatedSprite.flip_h = false
			
	if not animatedSprite.is_playing or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		animatedSprite.play("idle")
		
	was_on_floor = is_on_floor()
	move_and_slide()

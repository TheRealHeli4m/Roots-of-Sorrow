extends AnimatedSprite2D

@onready var was_on_floor = true
@onready var is_jumping = false
@onready var player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(self.is_playing())
	if not was_on_floor and player.is_on_floor():
		self.play("landing")
		await self.animation_finished
		is_jumping = false
	
	if Input.is_action_just_pressed("jump") and  player.is_on_floor():
		self.stop()
		is_jumping = true
		self.play("jump")

	if not is_jumping:
		if Input.is_action_pressed("move_left"):
			self.play("run")
			self.flip_h = true
		elif Input.is_action_pressed("move_right"):
			self.play("run")
			self.flip_h = false
			
	if not self.is_playing() or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		self.play("idle")
		
	was_on_floor = player.is_on_floor()

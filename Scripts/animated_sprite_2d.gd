extends AnimatedSprite2D

@onready var player = $".."
@onready var aTree = $"../AnimationTree"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aTree["parameters/conditions/is_idle"] = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.is_on_floor(), aTree["parameters/conditions/is_landing"])
	
	if player.velocity == Vector2.ZERO:
		aTree["parameters/conditions/is_idle"] = true
		aTree["parameters/conditions/is_running"] = false
	
	if Input.is_action_pressed("move_left"):
		aTree["parameters/conditions/is_running"] = true
		aTree["parameters/conditions/is_idle"] = false
		self.flip_h = true
	elif Input.is_action_pressed("move_right"):
		aTree["parameters/conditions/is_running"] = true
		aTree["parameters/conditions/is_idle"] = false
		self.flip_h = false
		
	if player.is_on_floor:
		if Input.is_action_just_pressed("jump"):
			aTree["parameters/conditions/is_jumping"] = true
			aTree["parameters/conditions/is_running"] = false
			aTree["parameters/conditions/is_idle"] = false
		elif player.was_on_floor:
			aTree["parameters/conditions/is_landing"] = true
			aTree["parameters/conditions/is_jumping"] = false
		else:
			aTree["parameters/conditions/is_jumping"] = false
			aTree["parameters/conditions/is_landing"] = false
	

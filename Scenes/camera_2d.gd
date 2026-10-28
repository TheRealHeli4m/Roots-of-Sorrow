extends Camera2D

@onready var root = $".."
@onready var calculatedPos: Vector2
@onready var mouseSprite = $"../Mouse"

var randomStrength = 5.0
var shakeFade = 5.0

var rng = RandomNumberGenerator.new()

var shakeStrength = 0.0
var mousePos: Vector2

# Called when the node enters the scense tree for the first time.
func _ready() -> void:
	mouseSprite.show()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	mousePos = get_global_mouse_position()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mousePos = get_global_mouse_position()
	mouseSprite.position = mousePos
	
	if Global.inMomMinigame:
		shakeStrength = lerpf(shakeStrength, 0, shakeFade * delta)
		mouseSprite.offset = randomOffset()
		
	if root.currentRoom == "cabinet": 
		calculatedPos = get_viewport().get_mouse_position() / 32
		self.position = calculatedPos
	if not root.isTurning:
		calculatedPos = get_viewport().get_mouse_position() / 16
		self.position = calculatedPos
		
func apply_shake() -> void:
	shakeStrength = randomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))

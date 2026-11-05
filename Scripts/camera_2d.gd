extends Camera2D

@onready var root = $".."
@onready var calculatedPos: Vector2


var randomStrength = 5.0
var shakeFade = 5.0
var randomLimit = 1

var rng = RandomNumberGenerator.new()

var shakeStrength = 0.0
var mousePos: Vector2

# Called when the node enters the scense tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	if root.currentRoom == "cabinet": 
		calculatedPos = get_viewport().get_mouse_position() / 32
		self.position = calculatedPos
	if not root.isTurning:
		calculatedPos = get_viewport().get_mouse_position() / 16
		self.position = calculatedPos
		

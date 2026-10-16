extends Camera2D

@onready var root = $".."
@onready var calculatedPos: Vector2

# Called when the node enters the scense tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not root.isTurning:
		calculatedPos = get_viewport().get_mouse_position() / 16
		self.position = calculatedPos

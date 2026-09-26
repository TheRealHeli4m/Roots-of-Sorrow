extends Camera2D

@onready var player = $"../Player"
@onready var targetOffset = Vector2.ZERO
@onready var xoffset = 60.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Global.playerInCamlockArea:
		self.position.y = lerp(self.position.y, 411.0, 5.0 * delta)
		return 
		
	var playerVelo = Global.player.velocity
	if abs(playerVelo.x) >= 500.0:
		targetOffset = Vector2(sign(playerVelo.x) * xoffset, 0)
	
	var targetPos = player.position + targetOffset
		
	self.position = self.position.lerp(targetPos, 10.0 * delta)

	targetOffset *= 0

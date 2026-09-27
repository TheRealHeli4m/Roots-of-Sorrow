extends Camera2D

@onready var player = $"../Player"
@onready var targetOffset = Vector2.ZERO
@onready var targetXPos;
@onready var xoffset = 60.0
@onready var fixedCam = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = 400
	targetXPos = player.position.x

func _physics_process(delta: float) -> void:
	if Global.playerInCamlockArea:
		self.position.y = lerp(self.position.y, 400.0, 5.0 * delta)
		return 
		
	if fixedCam: return
		
	if abs(player.lastOnGroundYPos - player.position.y) > 150:
		self.position.y = lerp(self.position.y, player.position.y, 10.0 * delta)
	else:
		var lerpPos = player.position.y + (self.position.y - player.position.y) 
		self.position.y = lerp(self.position.y, lerpPos, 10.0 * delta)
		
	var playerVelo = Global.player.velocity
	if abs(playerVelo.x) >= 500.0:
		targetOffset = sign(playerVelo.x) * xoffset
	
		targetXPos = player.position.x + targetOffset
		
	self.position.x = lerp(self.position.x, targetXPos, 10.0 * delta)

	targetOffset *= 0

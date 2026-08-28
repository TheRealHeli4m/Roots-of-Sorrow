extends Camera3D

@onready var camera = $"."
@onready var cameraAcc = 0.001
@onready var cameraXVel = 0
@onready var cameraYVel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cameraPos = get_viewport().get_mouse_position()
	camera.global_rotation.y += cameraXVel
	camera.global_rotation.x += cameraYVel
	
	if cameraPos.y < 100 && camera.global_rotation.x < PI / 16:
		cameraYVel += cameraAcc
	elif cameraPos.y > 500 && camera.global_rotation.x > -PI / 16:
		cameraYVel -= cameraAcc
	else:
		cameraYVel = 0
	
	if cameraPos.x < 200 && camera.global_rotation.y < PI / 16:
		cameraXVel += cameraAcc
	elif cameraPos.x > 900 && camera.global_rotation.y > -PI / 16:
		cameraXVel -= cameraAcc
	else:
		cameraXVel = 0
	

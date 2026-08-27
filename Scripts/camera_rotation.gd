extends Camera3D

@onready var camera = $"."
@onready var cameraVel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cameraPos = get_viewport().get_mouse_position()
	camera.global_rotation.y += cameraVel
	
	print(camera.global_rotation.y)
	if cameraPos.x < 100 && camera.global_rotation.y < PI / 4:
		cameraVel = 0.01
	elif cameraPos.x > 1000 && camera.global_rotation.y > -PI / 4:
		cameraVel = -0.01
	else:
		cameraVel = 0
	

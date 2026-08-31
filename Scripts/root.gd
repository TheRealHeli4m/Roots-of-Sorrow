extends Node

@onready var colorRect = $CanvasLayer/ColorRect
@onready var roomScene = $"3d_room"
@onready var gameboyScene = $GameboyCanvas
@onready var currentScene = "room"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameboyScene.hide()
	colorRect.modulate.a = 0
	
func _input(event: InputEvent) -> void:
	if currentScene == "room" && event.is_action_pressed("switch_scenes"):
		currentScene = "gameboy"
		gameboyScene.show()
		roomScene.hide()
		flash()
	elif currentScene == "gameboy" && event.is_action_pressed("switch_scenes"):
		currentScene = "room"
		gameboyScene.hide()
		roomScene.show()
		flash()
		
func flash():
	colorRect.modulate.a = 1.0 
	colorRect.move_to_front()
	var tween = create_tween()
	tween.tween_property(colorRect, "modulate:a", 0.0, 0.75)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

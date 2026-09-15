extends Node

@onready var canvas = $Flash
@onready var colorRect = $Flash/ColorRect
@onready var roomScene = $"3d_room"
@onready var gameboyScene = $gameboy
@onready var currentScene = "room"

@onready var gameboyCursor = load("res://Assets/Sewing/gameboy_mouse_cursor.png")
@onready var scissorsCursor = load("res://Assets/Sewing/gameboy_scissors_cursor.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameboyScene.hide()
	canvas.show()
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
func _process(_delta: float) -> void:
	if currentScene == "room":
		Input.set_custom_mouse_cursor(null)
	if currentScene == "gameboy":
		Input.set_custom_mouse_cursor(scissorsCursor)

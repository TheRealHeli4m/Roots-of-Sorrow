extends Node

@onready var canvas = $Flash
@onready var colorRect = $Flash/ColorRect
@onready var roomScene = $"3d_room"
@onready var gameboyScene = $gameboy

@onready var gameboycam: Camera2D = get_node("gameboy/Camera2D")
@onready var roomcam: Camera2D = get_node("3d_room/Camera2D")

signal open
signal close

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.open.connect(roomScene.openGameboy)
	self.close.connect(roomScene.closeGameboy)
	Global.currentRoom = Global.rooms.hallway
	gameboyScene.hide()
	canvas.show()
	colorRect.modulate.a = 0
	roomcam.make_current()
	
func _input(event: InputEvent) -> void:
	if Global.currentScene == "room" && event.is_action_pressed("switch_scenes"):
		self.open.emit()
		await roomScene.openGameboy()
		
		Global.currentScene = "gameboy"
		gameboyScene.show()
		roomScene.hide()
		gameboycam.make_current()
		flash()
	elif  Global.currentScene == "gameboy" && event.is_action_pressed("switch_scenes"):
		Global.currentScene = "room"
		gameboyScene.hide()
		roomScene.show()
		roomcam.make_current() 
		flash()
		self.close.emit()
		
func fetchCorrectRoom() -> void:
	pass

func flash():
	colorRect.modulate.a = 1.0
	colorRect.move_to_front()
	var tween = create_tween()
	tween.tween_property(colorRect, "modulate:a", 0.0, 1.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.currentScene == "room":
		Input.set_custom_mouse_cursor(null)

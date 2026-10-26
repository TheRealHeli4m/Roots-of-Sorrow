extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var gameboy = $Gameboy
@onready var currentRoom = "door"
@onready var camera = $Camera2D

@onready var window = $Window
@onready var door = $Door
@onready var cabinet = $Cabinet
@onready var isTurning = false
@onready var turnAnim = $CanvasLayer/AnimationPlayer
@onready var turnColRect = $CanvasLayer/ColorRect

@onready var switchToCabinetAnim = $CanvasLayer2/SwitchToCabinet
@onready var cabinetSprite = $Door/Cabinet/AnimatedSprite2D
@onready var cabinetHighlight = $Door/CabinetHighlight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turnColRect.modulate.a = 0
	currentRoom = "door"
	gameboy.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.currentScene == "room":
		if currentRoom == "cabinet":
			if Input.is_action_just_pressed("escape") or Input.is_action_just_pressed("scroll_banner_up"):
				switchToCabinetAnim.play("change_room")
				cabinetSprite.frame = 0
				cabinetHighlight.show()
				await get_tree().create_timer(0.25).timeout
				currentRoom = "door"
				
		else:
			if Input.is_action_just_pressed("move_left"):
				turnAnim.play("change_room")
				turn(true)
			if Input.is_action_just_pressed("move_right"):
				turnAnim.play("change_room")
				turn(false)
		
	if currentRoom == "door":
		window.hide()
		door.show()
		cabinet.hide()
	elif currentRoom == "window":
		window.show()
		door.hide()
		cabinet.hide()
	else:
		cabinet.show()
		window.hide()
		door.hide()

func openGameboy() -> bool:
	gameboy.show()
	animPlayer.play("open_gameboy")
	
	await animPlayer.animation_finished
	return true
	
func closeGameboy() -> bool:
	gameboy.show()
	animPlayer.play_backwards("open_gameboy")
	
	await animPlayer.animation_finished
	gameboy.hide()
	return true
	
func turn(isLeft: bool) -> void:
	isTurning = true
	if isLeft:
		var tweenstart = create_tween()
		tweenstart.tween_property(camera, "position", Vector2(-1000, 0), 0.2)
		
		await tweenstart.finished
		
		currentRoom = "door" if currentRoom == "window" else "window"
		camera.position = Vector2(1000, 0)
		var tweenend = create_tween()
		tweenend.tween_property(camera, "position", camera.calculatedPos, 0.2)
		
		await tweenend.finished
	else:
		var tweenstart = create_tween()
		tweenstart.tween_property(camera, "position", Vector2(1000, 0), 0.2)
		
		await tweenstart.finished
		
		currentRoom = "door" if currentRoom == "window" else "window"
		camera.position = Vector2(-1000, 0)
		var tweenend = create_tween()
		tweenend.tween_property(camera, "position", camera.calculatedPos, 0.2)
		
		await tweenend.finished
	isTurning = false

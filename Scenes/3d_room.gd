extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var gameboy = $Gameboy
@onready var isCurrentRoomDoor = true
@onready var camera = $Camera2D

@onready var window = $Window
@onready var door = $Door
@onready var isTurning = false
@onready var turnAnim = $CanvasLayer/AnimationPlayer
@onready var turnColRect = $CanvasLayer/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turnColRect.modulate.a = 0
	isCurrentRoomDoor = true
	gameboy.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left") and Global.currentScene == "room":
		turnAnim.play("change_room")
		turn(true)
	if Input.is_action_just_pressed("move_right") and Global.currentScene == "room":
		turnAnim.play("change_room")
		turn(false)
		
	if isCurrentRoomDoor:
		window.hide()
		door.show()
	else:
		window.show()
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
		
		isCurrentRoomDoor = false if isCurrentRoomDoor else true
		camera.position = Vector2(1000, 0)
		var tweenend = create_tween()
		tweenend.tween_property(camera, "position", camera.calculatedPos, 0.2)
		
		await tweenend.finished
	else:
		var tweenstart = create_tween()
		tweenstart.tween_property(camera, "position", Vector2(1000, 0), 0.2)
		
		await tweenstart.finished
		
		isCurrentRoomDoor = false if isCurrentRoomDoor else true
		camera.position = Vector2(-1000, 0)
		var tweenend = create_tween()
		tweenend.tween_property(camera, "position", camera.calculatedPos, 0.2)
		
		await tweenend.finished
	isTurning = false

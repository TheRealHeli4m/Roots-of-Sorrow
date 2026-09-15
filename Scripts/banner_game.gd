extends Node2D

@onready var isTweening = false
@onready var isPlaying: bool
@onready var player = get_node("/root/root/gameboy/Player")
@onready var scissors = $SewBox/Scissors

@onready var gameboyCursor = load("res://Assets/Sewing/gameboy_mouse_cursor.png")
@onready var scissorsCursor = load("res://Assets/Sewing/gameboy_scissors_cursor.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playOpeningAnim()
	
func _process(delta: float) -> void:
	determineCursor()
		
func determineCursor() -> void:
	if Global.currentScene == "room": return
	if not isPlaying: return
	
	if scissors.currentTool == scissors.tools.SCISSORS:
		Input.set_custom_mouse_cursor(scissorsCursor)
	elif scissors.currentTool == scissors.tools.NONE:
		Input.set_custom_mouse_cursor(gameboyCursor)
	
func playOpeningAnim() -> void:
	if isTweening:
		return
	
	isPlaying = true
	$Table.visible = true
	$SewBox.visible = true	
	isTweening = true
	
	$Table.position.y = 1200
	var tabletween = create_tween()
	tabletween.tween_property($Table, "position:y", 400, 1.0)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	$SewBox.position.y = 800
	var sewtween = create_tween()
	sewtween.tween_property($SewBox, "position:y", -50, 1.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	await sewtween.finished
	isTweening = false
		
		
func playClosingAnim() -> void:
	if isTweening:
		return
	
	isPlaying = false
	isTweening = true
	var tabletween = create_tween()
	tabletween.tween_property($Table, "position:y", 1200, 1.0)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	var sewtween = create_tween()
	sewtween.tween_property($SewBox, "position:y", 800, 1.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	
	await sewtween.finished
	$Table.visible = false
	$SewBox.visible = false
	isTweening = false

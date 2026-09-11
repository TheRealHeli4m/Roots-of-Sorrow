extends Node2D

@onready var isTweening = false
@onready var player = get_node("/root/root/gameboy/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playOpeningAnim()
	
func playOpeningAnim() -> void:
	
	if isTweening:
		return
	
	$Table.visible = true
	$SewBox.visible = true	
	isTweening = true
	
	$Table.position.y = 1200
	var tabletween = create_tween()
	tabletween.tween_property($Table, "position:y", 400, 1.0)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	$SewBox.position.y = 400
	var sewtween = create_tween()
	sewtween.tween_property($SewBox, "position:y", -50, 1.0)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	await sewtween.finished
	isTweening = false
		
		
func playClosingAnim() -> void:
	if isTweening:
		return
	
	isTweening = true
	var tabletween = create_tween()
	tabletween.tween_property($Table, "position:y", 1200, 1.0)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	var sewtween = create_tween()
	sewtween.tween_property($SewBox, "position:y", 400, 1.0)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	
	await sewtween.finished
	$Table.visible = false
	$SewBox.visible = false
	isTweening = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

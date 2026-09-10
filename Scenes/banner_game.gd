extends Node2D

@onready var isTweening = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playOpeningAnim()
	
func playOpeningAnim() -> void:
	
	if isTweening:
		return
	
	$Table.visible = true
	$Control.visible = true	
	isTweening = true
	
	$Table.position.y = 1200
	var tabletween = create_tween()
	tabletween.tween_property($Table, "position:y", 400, 1.5)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	$Control.position.y = 400
	var sewtween = create_tween()
	sewtween.tween_property($Control, "position:y", -50, 1.5)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	await sewtween.finished
	isTweening = false
		
		
func playClosingAnim() -> void:
	if isTweening:
		return
	
	isTweening = true
	var tabletween = create_tween()
	tabletween.tween_property($Table, "position:y", 1200, 1.5)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	var sewtween = create_tween()
	sewtween.tween_property($Control, "position:y", 400, 1.5)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	
	await sewtween.finished
	$Table.visible = false
	$Control.visible = false
	isTweening = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(isTweening)

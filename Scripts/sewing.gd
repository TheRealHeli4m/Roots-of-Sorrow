extends Control

@onready var hoverSprite = $HighlightOverlay
@onready var sewboxLid = $SewBoxLid
@onready var animatedSewboxLid = $SewBoxLid/AnimatedSprite2D
@onready var scissors = $Scissors
@onready var needle = $Needle
var isFlipped: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSewboxLid.stop()
	animatedSewboxLid.frame = 0
	hoverSprite.modulate.a = 0
	scissors.visible = false
	isFlipped = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isFlipped:
		sewboxLid.mouse_filter = Control.MOUSE_FILTER_IGNORE

func onSewBoxPressed() -> void:
	if isFlipped: return
	
	isFlipped = true
	hoverSprite.visible = false
	animatedSewboxLid.play("default")
	scissors.visible = true
	
	await animatedSewboxLid.animation_finished
	move_child(scissors, get_child_count() - 1)
	move_child(needle, get_child_count() - 1)
	
func onMouseEnterSewbox() -> void:
	if isFlipped: return
	
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 1.0, 0.2)

func onMouseExitSewbox() -> void:
	if isFlipped: return
	
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 0.0, 0.2)

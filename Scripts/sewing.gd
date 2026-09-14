extends Control

@onready var hoverSprite = $HighlightOverlay
@onready var texture = $TextureButton
@onready var animatedSewboxLid = $TextureButton/AnimatedSprite2D
@onready var scissors = $"../Scissors"
var isFlipped: bool

const scissorsOffset = 52 # scissors texture was off by a bit so i had to brute forcee it

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animatedSewboxLid.stop()
	animatedSewboxLid.frame = 1
	hoverSprite.modulate.a = 0
	scissors.visible = false
	isFlipped = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scipos = self.position - Vector2(scissorsOffset, 0)
	scissors.position = scipos

func onSewBoxPressed() -> void:
	if isFlipped: return
	
	isFlipped = true
	hoverSprite.visible = false
	animatedSewboxLid.play("default")
	
	await animatedSewboxLid.animation_finished
	scissors.visible = true
	
func onMouseEnterSewbox() -> void:
	if isFlipped: return
	
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 1.0, 0.2)

func onMouseExitSewbox() -> void:
	if isFlipped: return
	
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 0.0, 0.2)

extends Control

@onready var hoverSprite = $HighlightOverlay
@onready var texture = $TextureButton
@onready var scissors = $"../Scissors"

@onready var open = load("res://Assets/Sewing/open_sewing_box.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hoverSprite.modulate.a = 0
	scissors.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scipos = self.position - Vector2(52, 0)
	scissors.position = scipos

func onSewBoxPressed() -> void:
	hoverSprite.modulate.a = 0
	texture.texture_normal = open
	scissors.visible = true
	
func onMouseEnterSewbox() -> void:
	if texture.texture_normal != open:
		var tween = create_tween()
		tween.tween_property(hoverSprite, "modulate:a", 1.0, 0.25)

func onMouseExitSewbox() -> void:
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 0.0, 0.25)

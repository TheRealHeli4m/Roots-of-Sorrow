extends Control

@onready var hoverSprite = $HighlightOverlay
@onready var texture = $TextureButton

@onready var open = load("res://Assets/Sewing/open_sewing_box.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hoverSprite.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_button_mouse_entered() -> void:
	if texture.texture_normal != open:
		var tween = create_tween()
		tween.tween_property(hoverSprite, "modulate:a", 1.0, 0.25)


func _on_texture_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 0.0, 0.25)


func _on_texture_button_pressed() -> void:
	hoverSprite.modulate.a = 0
	texture.texture_normal = open

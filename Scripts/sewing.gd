extends Control

@onready var hoverSprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hoverSprite.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_button_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 1.0, 0.25)


func _on_texture_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(hoverSprite, "modulate:a", 0.0, 0.25)

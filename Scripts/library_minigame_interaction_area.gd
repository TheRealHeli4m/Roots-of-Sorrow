extends Area2D

@onready var overlay = $"../HighlightOverlay"
@onready var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	overlay.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		overlay.move_to_front()
		tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 1.0, 0.25)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		overlay.move_to_front()
		tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 0.0, 0.25)

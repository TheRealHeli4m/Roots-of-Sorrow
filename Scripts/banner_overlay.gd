extends Area2D

@onready var overlay = $"../SelectOverlay"
@onready var UIcanvaslayer = $"../../UI"
@onready var isPlayerIn = false
const sewing = preload("res://Scenes/banner_game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	overlay.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPlayerIn and Input.is_action_just_pressed("interact"):
		var sewing_inst = sewing.instantiate()
		UIcanvaslayer.add_child(sewing_inst)

func _on_body_entered(body: Node2D) -> void:
	isPlayerIn = true
	overlay.move_to_front()
	var tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 1.0, 0.25)

func _on_body_exited(body: Node2D) -> void:
	isPlayerIn = false
	overlay.move_to_front()
	var tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, 0.25)
	

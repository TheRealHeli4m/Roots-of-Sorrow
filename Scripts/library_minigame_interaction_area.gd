extends Area2D

@onready var overlay = $"../HighlightOverlay"
@onready var tween: Tween
@onready var isPlayerIn = false
@onready var UI = $"../CanvasLayer"

@onready var libraryGame: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	libraryGame = preload("res://Scenes/library_game.tscn").instantiate()
	overlay.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		libraryGame.hide()
		Global.player.canMove = true
	
	if Input.is_action_just_pressed("interact") and isPlayerIn:
		libraryGame.show()
		Global.player.canMove = false
		if UI.get_child_count() == 0:
			UI.add_child(libraryGame)



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		isPlayerIn = true
		overlay.move_to_front()
		tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 1.0, 0.25)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		isPlayerIn = false
		overlay.move_to_front()
		tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 0.0, 0.25)

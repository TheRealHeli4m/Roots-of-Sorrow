extends Node2D

@onready var animPlayer = $AnimationPlayer
@onready var gameboy = $Gameboy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func openGameboy() -> bool:
	gameboy.show()
	animPlayer.play("open_gameboy")
	
	await animPlayer.animation_finished
	return true
	
func closeGameboy() -> bool:
	gameboy.show()
	animPlayer.play_backwards("open_gameboy")
	
	await animPlayer.animation_finished
	gameboy.hide()
	return true

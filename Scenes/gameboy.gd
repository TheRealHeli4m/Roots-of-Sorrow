extends Node2D

@export var hallway = load("res://Scenes/hallway.tscn")
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hallwayInst = hallway.instantiate()
	self.add_child(hallwayInst)
	player.move_to_front()
	player.currentScene = hallwayInst

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

@onready var UIcanvaslayer = $UI
@onready var bannerGameInteraction = $Walls/BannerMinigameInteractionArea

@onready var gameboyCursor = load("res://Assets/Cursors/gameboy_mouse_cursor.png")
@onready var scissorsCursor = load("res://Assets/Cursors/gameboy_scissors_cursor.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bannerGameInteraction.isSewing == false and Global.currentScene == "gameboy":
		Input.set_custom_mouse_cursor(gameboyCursor)

func _on_visibility_changed() -> void:
	if UIcanvaslayer:
		UIcanvaslayer.visible = self.visible

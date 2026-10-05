extends TextureButton

@onready var root = $".."
@onready var highlight = $Highlight
@onready var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pivot_offset = self.size / 2
	highlight.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(highlight, "modulate:a", 0.75, 0.25)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(highlight, "modulate:a", 0, 0.25)


func _on_button_down() -> void:
	if selected:
		tweenDown()
		root.selectedArray.erase(self)
		selected = false
	elif not selected:
		tweenUp()
		root.selectedArray.append(self)
		selected = true

func tweenDown() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(8, 8), 0.2)
	
func tweenUp() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(9, 9), 0.2)

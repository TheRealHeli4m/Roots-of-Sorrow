extends Control

const gridSize = 48
var activeColor = Color(1, 0, 0)
var isPainting = false

@onready var grid = $GridContainer
@onready var modelSprite = $ModelBannerSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateGrid()

func generateGrid() -> void:
	grid.columns = gridSize
	
	for i in range(gridSize * 120):
		var cell = TextureButton.new()
		
		cell.custom_minimum_size = Vector2(8, 8)
		cell.stretch_mode = TextureButton.STRETCH_SCALE
		cell.ignore_texture_size = true
		cell.texture_normal = load("res://Assets/Sewing/white_cell.png")
		
		grid.add_child(cell)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			isPainting = true
		
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			isPainting = false
			
	if isPainting:
		var cellUnderMouse = getCellUnderMouse(get_viewport().get_mouse_position())
		if cellUnderMouse:
			cellUnderMouse.modulate = activeColor
		
func getCellUnderMouse(mousePos: Vector2) -> TextureButton:
	var buttons = grid.get_children()
	for i in range(buttons.size()):
		var cell = buttons[i]
		var cellPos = cell.global_position
		var cellSize = cell.custom_minimum_size
		
		if cellPos.x <= mousePos.x and mousePos.x <= cellPos.x + cellSize.x and cellPos.y <= mousePos.y and mousePos.y <= cellPos.y + cellSize.y:
			return cell
			
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("scroll_banner_down"):
		self.position.y -= 5
	if Input.is_action_pressed("scroll_banner_up"):
		self.position.y += 5

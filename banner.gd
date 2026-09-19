extends Control

const gridSize = 32
var activeColor = Color(1, 0, 0)
var isPainting = false

@onready var grid = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateGrid()

func generateGrid() -> void:
	grid.columns = gridSize
	
	for i in range(gridSize * gridSize): # square
		var cell = TextureButton.new()
		
		cell.custom_minimum_size = Vector2(16, 16)
		cell.stretch_mode = TextureButton.STRETCH_SCALE
		cell.ignore_texture_size = true
		cell.texture_normal = load("res://Assets/Sewing/white_cell.png")
		
		var cellScale = Vector2(8, 8)
		cell.scale = cellScale
		
		grid.add_child(cell)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			isPainting = true
		
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			isPainting = false
			
	if isPainting:
		var cellUnderMouse = getCellUnderMouse(event.position)
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
	pass

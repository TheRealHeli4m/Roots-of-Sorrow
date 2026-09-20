extends Control

const gridSize = 48
var activeColor = Color(1, 0, 0)
var isPainting = false

@onready var grid = $GridContainer
@onready var padder = $BannerPadder
@onready var modelSprite = $ModelBannerSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateGrid()

func generateGrid() -> void:
	grid.columns = gridSize
	
	for i in range(gridSize * 120):
		var cell = ColorRect.new()
		
		cell.custom_minimum_size = Vector2(8, 8)
		
		grid.add_child(cell)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			isPainting = true
		if event.button_index == MOUSE_BUTTON_LEFT and !event.is_pressed():
			isPainting = false
			
	if isPainting:
		var cellsUnderArea = getCellsUnderArea()
		var cells = grid.get_children()
		
		for i in range(cellsUnderArea.size()):
			cells[cellsUnderArea[i]].modulate = activeColor
		
func getCellsUnderArea() -> Array: # problem here is that area2d requires a collision shape to detect
	var cells = grid.get_children()
	var cellsList = []
	for i in range(cells.size()):
		var cell = cells[i]
		var isIn = checkCellInArea(cell)
		if isIn:
			cellsList.append(i)
			
	return cellsList

func checkCellInArea(cell: ColorRect) -> bool:
	var mousePos = get_local_mouse_position()
	var mpLeft = mousePos.x - 16
	var mpRight = mousePos.x + 16
	var mpUp = mousePos.y - 16
	var mpDown = mousePos.y + 16
	var cellPos = cell.position
	
	if mpLeft < cellPos.x and cellPos.x < mpRight:
		if mpUp < cellPos.y and cellPos.y < mpDown:
			return true

	return false

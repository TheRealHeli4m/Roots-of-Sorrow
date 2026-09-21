extends Control

const gridSize = 48
var activeColor = Color(1, 0, 0)
var isPainting = false

signal paintingFinished

@onready var grid = $GridContainer
@onready var modelSprite = $ModelBannerSprite

@onready var currentBanner = modelSprite.bannerTexture

@onready var totalCellsPainted = 0
@onready var usingPaint = totalCellsPainted < 5760

@onready var root = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateGrid()
	
func _process(delta: float) -> void:
	if totalCellsPainted == 5760:
		paintingFinished.emit()
		totalCellsPainted += 1
		

func generateGrid() -> void:
	grid.columns = gridSize
	
	for i in range(gridSize * 120):
		var cell = ColorRect.new()
		
		cell.color = Color(1, 1, 1)
		cell.custom_minimum_size = Vector2(8, 8)
		cell.set_meta("is_painted", false)
		
		grid.add_child(cell)
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			isPainting = true
		if event.button_index == MOUSE_BUTTON_LEFT and !event.is_pressed():
			isPainting = false
			
	if isPainting:
		var cells = grid.get_children()
		if root.currentTool == root.tools.PAINTBRUSH:
			var cellsUnderArea = getCellsUnderArea(32)
		
			for i in range(cellsUnderArea.size()):
				var currentcell = cells[cellsUnderArea[i]]
				currentcell.color = activeColor
				modelSprite.checkCellForCorrectColor(currentcell)
				
		if root.currentTool == root.tools.NEEDLE:
			var cellsUnderArea = getCellsUnderArea(8)
			for i in range(cellsUnderArea.size()):
				var currentcell = cells[cellsUnderArea[i]]
				currentcell.modulate.a = 1
				currentcell.color = activeColor
		if root.currentTool == root.tools.SCISSORS:
			var cellUnderMouse = getCellUnderMouse()
			if cellUnderMouse:
				cellUnderMouse.modulate.a = 0
			
func getCellUnderMouse() -> ColorRect:
	var cells = grid.get_children()
	for i in range(cells.size()):
		var cell = cells[i]
		var cellSize = cell.size
		var cellPos = cell.position
		var mousePos = get_local_mouse_position()
		
		if cellPos.x <= mousePos.x and mousePos.x <= cellPos.x + cellSize.x and cellPos.y <= mousePos.y and mousePos.y <= cellPos.y + cellSize.y:
			return cell
		
	return null
		
func getCellsUnderArea(size: int) -> Array: # problem here is that area2d requires a collision shape to detect
	var cells = grid.get_children()
	var cellsList = []
	for i in range(cells.size()):
		var cell = cells[i]
		var isIn = checkCellInArea(cell, size)
		if isIn:
			cellsList.append(i)
			
	return cellsList

func checkCellInArea(cell: ColorRect, size: int) -> bool:
	var mousePos = get_local_mouse_position()
	var mpLeft = mousePos.x - size
	var mpRight = mousePos.x + size
	var mpUp = mousePos.y - size
	var mpDown = mousePos.y + size
	var cellPos = cell.position
	
	if mpLeft < cellPos.x and cellPos.x < mpRight:
		if mpUp < cellPos.y and cellPos.y < mpDown:
			return true

	return false

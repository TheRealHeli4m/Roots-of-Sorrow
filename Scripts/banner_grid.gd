class_name PaintingResource
extends Resource

# resource holding the color grid when coloring

@export var colors: Array[Color]

func createFromGrid(gridButtons: Array):
	colors.resize(gridButtons.size())
	for i in range (gridButtons.size()):
		colors[i] = gridButtons[i].modulate
		
		
func loadToGrid(gridButtons: Array):
	for i in range(grid_buttons.size()):
		grid_buttons[i].modulate = colors[i]

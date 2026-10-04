extends Node2D

@onready var markerList = [$Markers/Marker2D, $Markers/Marker2D2, $Markers/Marker2D3, $Markers/Marker2D4, $Markers/Marker2D5]
@onready var posList: Array
@onready var orderedBookList: Array = [$Book1, $Book2, $Book3, $Book4, $Book5]
@onready var bookList = [$Book1, $Book2, $Book3, $Book4, $Book5]
@onready var bookOverlayTexture = load("res://Assets/Sewing/book_highlight_overlay.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for marker in markerList:
		if marker:
			posList.append(marker.position)
			
	bookList.shuffle()
	for i in range(bookList.size()):
		var book = bookList[i]
		book.position = posList[i]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

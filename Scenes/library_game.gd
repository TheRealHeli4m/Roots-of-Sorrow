extends Node2D

@onready var markerList = [$Markers/Marker2D, $Markers/Marker2D2, $Markers/Marker2D3, $Markers/Marker2D4, $Markers/Marker2D5]
@onready var posList: Array
@onready var orderedBookList: Array = [$Book1, $Book2, $Book3, $Book4, $Book5]
@onready var bookList = [$Book1, $Book2, $Book3, $Book4, $Book5]
@onready var bookOverlayTexture = load("res://Assets/Sewing/book_highlight_overlay.png")

@onready var selectedArray: Array = []

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
	if selectedArray.size() == 2:
		
		var index0 = bookList.find(selectedArray[0])
		var index1 = bookList.find(selectedArray[1])
		var book0pos = posList[index0]
		var book1pos = posList[index1]
		
		var tween0 = create_tween()
		tween0.tween_property(selectedArray[0], "position", book1pos, 0.3)
	
		var tween1 = create_tween()
		tween1.tween_property(selectedArray[1], "position", book0pos, 0.3)
		
		var temp = bookList[index0]
		bookList[index0] = bookList[index1]
		bookList[index1] = temp
		
		selectedArray[0].selected = false
		selectedArray[0].tweenDown()
		selectedArray[1].selected = false
		selectedArray[1].tweenDown()
		selectedArray.clear()

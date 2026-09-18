extends Node2D

@onready var root = $".."
@onready var modelBannerSprite = $ModelBannerSprite
@onready var emptyBanner = $EmptyBannerSprite


@onready var redbanner = load("res://Assets/Sewing/red_banner.png")
@onready var bluebanner = load("res://Assets/Sewing/blue_banner.png")
@onready var greenbanner = load("res://Assets/Sewing/green_banner.png")

@onready var bannerlist = [redbanner, bluebanner, greenbanner]

var velo: float
var acc: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velo = 0.0
	acc = 0.0
	var randomBannerTexture = bannerlist.pick_random()
	modelBannerSprite.texture = randomBannerTexture
	self.modulate.a = 0.5
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	emptyBanner.position = modelBannerSprite.position
	if not root.isPlayingBannerGame: return

	if Input.is_action_pressed("scroll_banner_up") and self.position.y > -300:
		acc = -2
	if Input.is_action_pressed("scroll_banner_down") and self.position.y < 100:
		acc = 2
		
	velo += acc
	self.position.y += velo
	
	acc = 0
	velo /= 1.25

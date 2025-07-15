extends Polygon2D

## The color the background should be.
@export var color_current: Color
## How far the bleed zone for the background should be as a percentage of the viewport's size.
var bleed_percentage : float = 0.05

func _init():
	color = color_current

func _ready():
	calculate_size()

func _process(delta):
	color = color_current
	pass

## Calculate the size the background should be given the bleed percentage and sets it to be that size.
func calculate_size():
	var viewport_size = get_viewport().get_visible_rect().size
	var bleed_x = viewport_size.x * bleed_percentage
	var bleed_y = viewport_size.y * bleed_percentage
	var point1 = Vector2(-1 * bleed_x, -1 * bleed_y)
	var point2 = Vector2(viewport_size.x + bleed_x, -1 * bleed_y)
	var point3 = Vector2(viewport_size.x + bleed_x, viewport_size.y + bleed_y)
	var point4 = Vector2(-1 * bleed_x, viewport_size.y + bleed_y)
	var poly = PackedVector2Array([point1, point2, point3, point4])
	set_polygon(poly)
	pass

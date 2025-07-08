extends Polygon2D

@export var color_current: Color
var bleed_percentage : float = 0.05

func _init():
	color = color_current

func _ready():
	calculate_size()

func _process(delta):
	pass

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

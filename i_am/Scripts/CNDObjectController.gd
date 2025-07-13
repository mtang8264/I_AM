# A script to control objects that are meant to be clicked and dragged
extends Node2D

var body : StaticBody2D
var shape : CollisionShape2D

var bound_left : float
var bound_right: float
var bound_top: float
var bound_bottom: float

func _ready():
	assign_child_variables()
	calculate_bounds()

func _process(delta):
	calculate_bounds()

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and event.as_text() == "Left Mouse Button":
			if is_point_inbounds(event.position.x, event.position.y):
				print("Inbound touch on obj ", name, " at position ", event.position)
			#print(event.position)

func assign_child_variables():
	body = find_children("*", "StaticBody2D")[0]
	#print(body)
	shape = find_children("*", "CollisionShape2D")[0]
	#print(shape)

func calculate_bounds():
	var rect = shape.shape.get_rect()
	bound_left = position.x + rect.position.x
	bound_right = position.x + rect.end.x
	bound_top = position.y + rect.position.y
	bound_bottom = position.y + rect.end.y
	#print(bound_left, bound_right, bound_top, bound_bottom)

func is_point_inbounds(x: float, y: float):
	return x >= bound_left and x <= bound_right and y >= bound_top and y <= bound_bottom

# A script to control objects that are meant to be clicked and dragged
extends Node2D

var body : StaticBody2D
var shape : CollisionShape2D

var bound_left : float
var bound_right: float
var bound_top: float
var bound_bottom: float

var held: bool = false
var held_starting_mouse_offset: Vector2 = Vector2.ZERO

func _ready():
	assign_child_variables()
	calculate_bounds()

func _process(delta):
	drag()
	calculate_bounds()
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		release()

func _input(event):
	if is_input_event_mouse_down_on_obj(event):
		#print("Inbound mousedown on obj ", name, " at position ", event.position)
		hold(event.position)

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

func is_point_inbounds(point: Vector2):
	return point.x >= bound_left and point.x <= bound_right and point.y >= bound_top and point.y <= bound_bottom

func is_input_event_mouse_down_on_obj(event):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and event.as_text() == "Left Mouse Button":
			if is_point_inbounds(event.position):
				return true
	return false

func hold(mouse_pos: Vector2):
	# Set the held variable to true
	held = true
	# Record the mouse position at the moment the object begins being held
	held_starting_mouse_offset = position - mouse_pos

func release():
	held = false
	held_starting_mouse_offset = Vector2.ZERO

func drag():
	if not held:
		return
	var mouse_pos = get_viewport().get_mouse_position()
	position = mouse_pos + held_starting_mouse_offset

# A script to control objects that are meant to be clicked and dragged
extends Node2D

# References to the child nodes used to make the script work
var body : StaticBody2D
var shape : CollisionShape2D

# The bounds of where the click detection should check
var bound_left : float
var bound_right: float
var bound_top: float
var bound_bottom: float

# Boolean storage of whether or not the object is being held
var held: bool = false
# Vector2 storage of the offset from the mouse when the object began being held
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
	if is_input_event_left_mouse_down_on_obj(event):
		#print("Inbound mousedown on obj ", name, " at position ", event.position)
		hold(event.position)

## Finds the child nodes required for script to function
func assign_child_variables():
	body = find_children("*", "StaticBody2D")[0]
	#print(body)
	shape = find_children("*", "CollisionShape2D")[0]
	#print(shape)

## Calculates the click box bounds based on the shape assigend to the child CollisionShape2D
func calculate_bounds():
	var rect = shape.shape.get_rect()
	bound_left = position.x + rect.position.x
	bound_right = position.x + rect.end.x
	bound_top = position.y + rect.position.y
	bound_bottom = position.y + rect.end.y
	#print(bound_left, bound_right, bound_top, bound_bottom)

## Returns true if the given point is within bounds of the object
func is_point_inbounds(point: Vector2):
	return point.x >= bound_left and point.x <= bound_right and point.y >= bound_top and point.y <= bound_bottom

## Returns true if the given event is a left mouse click inside the bounds of the click box
func is_input_event_left_mouse_down_on_obj(event):
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and event.as_text() == "Left Mouse Button":
			if is_point_inbounds(event.position):
				return true
	return false

## Void function used to mark the object as held
func hold(mouse_pos: Vector2):
	# Set the held variable to true
	held = true
	# Record the mouse position at the moment the object begins being held
	held_starting_mouse_offset = position - mouse_pos

## Void function used to release the obect from being held
func release():
	held = false
	held_starting_mouse_offset = Vector2.ZERO

func drag():
## Moves the object to the correct position given the mouse's new position
	if not held:
		return
	var mouse_pos = get_viewport().get_mouse_position()
	position = mouse_pos + held_starting_mouse_offset

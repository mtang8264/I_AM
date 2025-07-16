# A script to control objects that are meant to be clicked and dragged
extends Node2D

## Is the object currently grabbable
@export var is_grabbable: bool = true
## Should the object continue to move
@export var should_move: bool = true

@export_category("Drag Options")
enum Drag_Modes {
	## The object will use the default drag options assigned by GameManager.gd.
	DEFAULT = -1,
	## The object will immediately appear at the position of the mouse.
	INSTANT = 0,
	## The object will move at a specified speed per second toward the mouse.
	LINEAR_SPEED = 1,
	## The object will move a given percentage of the way to the mouse every frame.
	LERP = 2}
## The drag mode that should be used for this object.
@export var drag_mode: Drag_Modes = Drag_Modes.DEFAULT
## The value used by the object to determine its movement for some Drag Modes.[br]
## [b]INSTANT:[/b] No drag_value is needed.[br]
## [b]LINEAR_SPEED:[/b] drag_value is the speed the object moves per second. Values need to be very high, around 1000.[br]
## [b]LERP:[/b] drag_value is the percentage of the distance moved each frame. Should be between 0 and 1. Ideally around 0.1.
@export var drag_value: float = 0

# References to the child nodes used to make the script work
var body : StaticBody2D ## The StaticBody2D that is childed to this node.
var shape : CollisionShape2D ## The CollisionShape2D that is childed to this node.

## The bounds of where the click detection should check
var bound_left : float
var bound_right: float
var bound_top: float
var bound_bottom: float

## Boolean storage of whether or not the object is being held
var held: bool = false
## Vector2 storage of the offset from the mouse when the object began being held
var held_starting_mouse_offset: Vector2 = Vector2.ZERO

## The position that the object wants to be at.
var target_position: Vector2 = Vector2.ZERO

func _ready():
	set_target_position(position)
	
	if drag_mode == Drag_Modes.DEFAULT:
		drag_mode = int(GameManager.drag_mode_default)
		drag_value = GameManager.drag_value_default
	
	assign_child_variables()
	calculate_bounds()

func _process(delta):
	drag(delta)
	calculate_bounds()
	# If the left mouse button is not being held or the object is no longer grabbable, the object should be released.
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or not is_grabbable:
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
	# Immediately exit the function if the object is not currently grabbable
	if not is_grabbable:
		return
		
	# Set the held variable to true
	held = true
	# Record the mouse position at the moment the object begins being held
	held_starting_mouse_offset = position - mouse_pos

## Void function used to release the obect from being held
func release():
	held = false
	held_starting_mouse_offset = Vector2.ZERO

## Moves the object to the correct position given the mouse's new position
func drag(delta: float):
	# If the object should not move then we don't want this func to execute
	if not should_move:
		return
	# If the object is currently being held then the target position is based on mouse position
	# There are theoretically other reasons the object should move so the script continues if this is not true
	if held:
		var mouse_pos = get_viewport().get_mouse_position()
		set_target_position(mouse_pos + held_starting_mouse_offset)
	
	match drag_mode:
		Drag_Modes.INSTANT:
			position = target_position
		Drag_Modes.LINEAR_SPEED:
			var dir = position.direction_to(target_position)
			var new_pos = position + (dir*drag_value*delta)
			position = new_pos
			return
		Drag_Modes.LERP:
			var new_pos = (target_position * drag_value) + (position * (1-drag_value))
			position = new_pos
			return

func set_target_position(pos: Vector2):
	target_position = pos

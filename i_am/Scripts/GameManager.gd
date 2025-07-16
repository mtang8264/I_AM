extends Node

enum Drag_Modes {
	## The object will immediately appear at the position of the mouse.
	INSTANT = 0,
	## The object will move at a specified speed per second toward the mouse.
	LINEAR_SPEED = 1,
	## The object will move a given percentage of the way to the mouse every frame.
	LERP = 2,
	## The object will move a given percentage of the way to the mouse every frame up to a maximum speed per second.
	LERP_BOUND = 3}
## The drag mode that should be used for this object.
@export var drag_mode_default: Drag_Modes = Drag_Modes.LERP_BOUND
## The value used by the object to determine its movement for some Drag Modes.[br]
## [b]INSTANT:[/b] No drag_value is needed.[br]
## [b]LINEAR_SPEED:[/b] drag_value is the speed the object moves per second. Values need to be very high, around 1000.[br]
## [b]LERP:[/b] drag_value is the percentage of the distance moved each frame. Should be between 0 and 1. Ideally around 0.1.
@export var drag_value_default: float = 0.1
## THe maximum speed in pixels per second the object can move to get to its target. Only used for Drag_Modes.LERP_BOUND.
@export var drag_max_speed_per_second_default: float = 1500

func _ready():
	randomize()

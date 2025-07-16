extends Node

@export_category("Words In Scene")
@export var word_i: Node2D
@export var word_am: Node2D

var word_am_default_position: Vector2
var word_i_default_position: Vector2

var viewport_size: Vector2

var completed: bool = false

func _ready():
	viewport_size = get_viewport().get_visible_rect().size
	
	word_am_default_position = word_am.position
	word_i_default_position = word_i.position

func _process(delta):
	if not completed:
		check_solution()
	
	move_words_to_default_positions()

func move_words_to_default_positions():
	if not completed:
		if not word_am.held:
			word_am.set_target_position(word_am_default_position)
		if not word_i.held:
			word_i.set_target_position(word_i_default_position)
	else:
		word_am.set_target_position(word_i_default_position)
		word_i.set_target_position(word_am_default_position)

func check_solution():
	# if both objects are not held
	if not word_am.held and not word_i.held:
		# if I is to the left of AM
		if word_i.position.x < word_am.position.x:
			mark_as_completed()

func mark_as_completed():
	completed = true
	word_am.is_grabbable = false
	word_i.is_grabbable = false
	pass

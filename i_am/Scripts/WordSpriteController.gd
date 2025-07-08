extends Sprite2D

@export var path_to_sprites : String
var file_extention: String = ".png"
@export var sprite_variation_count : int

var sprites = Array([], TYPE_OBJECT, "CompressedTexture2D", null)

@export var change_time_float: float = 0.2
var change_timer = 0

var current_sprite_index = 0
var recent_sprites = Array([], TYPE_INT, "", null)
var recent_sprites_memory_slots = 5

func _ready():
	load_sprites()
	select_default_sprite()
	change_timer = change_time_float
	pass

func _process(delta):
	change_timer = change_timer - delta
	if change_timer <= 0:
		change_sprite()

func load_sprites():
	for x in range(sprite_variation_count):
		sprites.append(load(path_to_sprites + str(x) + file_extention))

func select_default_sprite():
	set_texture(sprites[0])
	recent_sprites.append(0)
	pass

func change_sprite():
	# Create a list of all the indexes that have not been used recently
	var possible_choices = Array([], TYPE_INT, "", null)
	for x in range(sprite_variation_count):
		if recent_sprites.has(x) == false:
			possible_choices.append(x)
			
	# If somehow there are no possible choices, just use the first option
	if possible_choices.size() <= 0:
		push_warning("Couldn't select a texture that was not used in the last " + str(recent_sprites_memory_slots) + "selections.")
		current_sprite_index = 0
		recent_sprites.clear()
		return
	# Randomly pick the next choice
	var next_choice = randi() % possible_choices.size()
	current_sprite_index = possible_choices[next_choice]
	recent_sprites.append(current_sprite_index)
	while recent_sprites.size() > recent_sprites_memory_slots:
		recent_sprites.remove_at(0)
	change_timer = change_time_float
	set_texture(sprites[current_sprite_index])
	print("Chaning sprite to variation " + str(current_sprite_index))
	

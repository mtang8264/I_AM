extends Sprite2D

# The path to the word's textures
var path_to_sprites : String
# The file extension of the word's textures
var file_extention: String = ".png"

# Array of all the textures for the word
var sprites = Array([], TYPE_OBJECT, "CompressedTexture2D", null)

## A range of the possible durations for each sprite to be shown for.
@export var change_time_range: Vector2 = Vector2(0.15,0.25)
## The timer to track when the sprite should change.
var change_timer:float = 0

## The index in the sprites array of the current sprite 
var current_sprite_index = 0
## Memory of the most recent sprites used so they do not reappear too soon
var recent_sprites = Array([], TYPE_INT, "", null)
## The length of the memory for when not to reuse a sprite
var recent_sprites_memory_slots = 5

func _ready():
	load_sprites()
	change_timer = (change_time_range.x + change_time_range.y)/2
	pass

func _process(delta):
	change_timer = change_timer - delta
	if change_timer <= 0:
		change_sprite()

## Finds the resource files for the sprites and 
func load_sprites():
	# The directory which the starting texture is held within
	var dir = DirAccess.open( texture.resource_path.left( texture.resource_path.rfind("/")))
	# An array of the file names in the directory
	var dir_array = dir.get_files()
	# The number of files in the directory
	var dir_size = dir_array.size()
	
	# Go through each file in the directory and if it isn't a ".import" file add it to the list.
	for x in dir_size:
		var file = dir.get_current_dir() + "/" + dir.get_files()[x]
		if file.ends_with(".png"):
			sprites.append(load(file))

## Void function to change the sprite. Called when the timer has reached zero.
func change_sprite():
	# Create a list of all the indexes that have not been used recently
	var possible_choices = Array([], TYPE_INT, "", null)
	for x in range(sprites.size()):
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
	# Set the current sprite index to the new selection's index
	current_sprite_index = possible_choices[next_choice]
	# Add the new selection to the memory of recent selections
	recent_sprites.append(current_sprite_index)
	# If there are more entries in memory than we want, remove them until there isn't
	while recent_sprites.size() > recent_sprites_memory_slots:
		recent_sprites.remove_at(0)
	# Reset the timer
	change_timer = randf_range(change_time_range.x, change_time_range.y)
	set_texture(sprites[current_sprite_index])
	# print("Chaning sprite to variation " + str(current_sprite_index))
	

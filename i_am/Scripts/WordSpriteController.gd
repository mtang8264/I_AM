extends Sprite2D

# The path to the word's textures
var path_to_sprites : String
# The file extension of the word's textures
var file_extention: String = ".png"
# The number of unique variations of the texture there are
var sprite_variation_count : int

# Array of all the textures for the word
var sprites = Array([], TYPE_OBJECT, "CompressedTexture2D", null)

# A range of of the number of seconds the sprite waits to change
@export var change_time_range: Vector2 = Vector2(0.15,0.25)
# Timer to track when the sprite should change
var change_timer:float = 0

# The index in the sprites array of the current sprite 
var current_sprite_index = 0
# Memory of the most recent sprites used so they do not reappear too soon
var recent_sprites = Array([], TYPE_INT, "", null)
# The length of the memory for when not to reuse a sprite
var recent_sprites_memory_slots = 5

func _ready():
	load_sprites()
	change_timer = (change_time_range.x + change_time_range.y)/2
	pass

func _process(delta):
	change_timer = change_timer - delta
	if change_timer <= 0:
		change_sprite()

# Finds the resource files for the sprites and 
func load_sprites():
	# Breaks the resource_path of the starting texture into an array to work on it
	var path_array = Array(texture.resource_path.split("/", true))
	# Pop off the last element of the path array to seperate the file name format, then split it for editting
	var file_name_array = Array(path_array.pop_back().split("_",true))
	# Just take the parts of the file name before the number
	var file_name_string = file_name_array[0] + "_" + file_name_array[1] + "_"
	# Add the first part of the path_array back to a new string of the folder path
	var path_string = path_array[0]
	# Add all the other elements of the path with slashes
	for x in range(1,path_array.size()):
		path_string = path_string + "/" + str(path_array[x])
	# Open the directory so we can count how many variations there are
	var dir = DirAccess.open(path_string)
	# Add the pre-number part of the file name to the path
	path_string = path_string + "/" + file_name_string
	# Save that path for future use
	path_to_sprites = path_string
	
	# Count how many variations there are. This is divided by 2 because there is a texture and a .import file for each.
	sprite_variation_count = dir.get_files().size() / 2
	
	# Add each variation to the sprites array
	for x in range(sprite_variation_count):
		sprites.append(load(path_to_sprites + str(x) + file_extention))
	sprite_variation_count = sprites.size()

# Called when the sprite is changed.
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
	

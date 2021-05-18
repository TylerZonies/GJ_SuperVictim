extends Node2D

var dialog = "Hey baby!"
var dialog_size = "small"
var is_talking = false

var dialogs = {1: ["small", "Yelp"], 
2: ["small", "Did you check your pockets?"], 
3: ["small", "Do you live out here?"]}
var first_position = Vector2.ZERO
var new_position = Vector2.ZERO
var destination = Vector2.ZERO

onready var sprite = get_node("animation")
onready var yelp1 = get_node("yelp1")
onready var yelp2 = get_node("yelp2")
onready var yelp3 = get_node("yelp3")
onready var walk = get_node("walk")
var sound_array = []
var pos_mod = 16
var index = 0
var tick = 0
var speed = 1
var speed_mod = 0.2
var sound_played = false
func _ready():
	add_to_group("npc")
	first_position = position
	destination = first_position
	var random = randi()%3
	if random == 1:
		sprite.flip_h = true
	sound_array = [yelp1,yelp2,yelp3]
func tick():
	if tick == 0:
		speed = speed_mod
	else:
		speed = 0
func _process(delta):
	if move_to(destination):
		sprite.animation = "run"
		
	else:
		sprite.animation = "idle"
		walk.playing = false
func make_dialog():

	if is_talking == false:
		_rotate_dialog()
		get_node("NPC").make_dialog(dialog, dialog_size)

func _rotate_dialog():
	if index < dialogs.size():
		index += 1
	else:
		index = 1
	dialog_size = dialogs[index][0]
	dialog = dialogs[index][1]

func move_to(pos):
	if position.x < pos.x:
		position.x += speed
		sprite.flip_h = false
		return true
	elif position.x > pos.x:
		position.x -= speed
		sprite.flip_h = true
		return true
func _on_Timer_timeout():
	var random = randi()%10 #decide
	print(random)
	match random:
		4,5,6:
			sound_array[randi()%sound_array.size()].play()
	if position == first_position:
		match random:
			1:
				pos_mod = pos_mod * -1
				new_position = Vector2(first_position.x + pos_mod, first_position.y)
				destination = new_position
				walk.playing = true
			2:
				pos_mod = pos_mod * 1
				new_position = Vector2(first_position.x + pos_mod, first_position.y)
				destination = new_position
				walk.playing = true
	else:
		match random:
			1,3:
				destination = first_position
				walk.playing = true

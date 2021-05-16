extends Node2D

var dialog = "Hey baby!"
var dialog_size = "small"
var is_talking = false

var dialogs = {1: ["small", "Someone stole my records!"], 
2: ["big", "I wonder how much I can sell these VHS' for. Ralph's usually takes them."], 
3: ["small", "Do you live out here?"]}
var index = 0
func _ready():
	add_to_group("npc")

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

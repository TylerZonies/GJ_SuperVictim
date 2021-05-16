extends Node2D

var dialog = "Hey baby!"
var dialog_size = "small"
var is_talking = false

var dialogs = {1: ["big", "I was trying to help a customer and I accidentally left my Skooner on the roof. Do you mind helping me?"], 
2: ["small", "I need your help."], 
3: ["small", "I don't check ID's."]}
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

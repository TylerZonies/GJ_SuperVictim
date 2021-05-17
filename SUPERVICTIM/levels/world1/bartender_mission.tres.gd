extends Node2D

var dialog = "Hey baby!"
var dialog_size = "small"
var is_talking = false
var mission_complete = false
onready var player = get_parent().get_parent().get_node("player")
var dialogs = {1: ["big", "I was trying to help a customer and I accidentally left my Skooner on the roof. Do you mind helping me?"], 
2: ["small", "I need your help."], 
3: ["small", "I don't check ID's."]}
var secondary_dialogs = {1: ["big", "Oh! You found my Skooner! Thank you so much! Here's my number if you ever want to hang out."], 
2: ["small", "You check your pockets?"], 
3: ["small", "Hey babby!"]}
var index = 0
func _ready():
	add_to_group("npc")

func make_dialog():
	check_mission()
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
func check_mission():
	if player._has_item("Skooner") && !mission_complete:
		dialogs = secondary_dialogs
		index = 0
		mission_complete = true
		player.mission_completed = true
		player.items_held.append("oboy_ticket")
		$ooo.playing = true
func notify():
	pass

extends Node2D
var dialog = "Hey baby!"
var dialog_size = "small"
var is_talking = false
var mission_complete = false
onready var player = get_parent().get_parent().get_node("player")
var dialogs = {1: ["small", "Whassup."], 
2: ["big", "There's a gal at Skooners that I certainly lament. GBO and Buc-ee feel the same."], 
3: ["small", "O-BBBBOOOY!"]}
var secondary_dialogs = {1: ["big", "So.. you found my Skooner. There's some more folk that need some help, but here's some money for acquiring this."] }
var index = 0
func _ready():
	add_to_group("npc")

func make_dialog():
	if !check_mission():
		if is_talking == false:
			_rotate_dialog()
			get_node("NPC").make_dialog(dialog, dialog_size)
			player.start_timer()

func _rotate_dialog():
	if index < dialogs.size():
		index += 1
	else:
		index = 1
	dialog_size = dialogs[index][0]
	dialog = dialogs[index][1]
func check_mission():
	if player._has_item("Skooner") && !mission_complete:
		index = 0
		mission_complete = true
		$oboy.playing = true
		DialogManager._create_dialog(self, "Nice! You found my microphone. Now I can get down to the real jig. There is some unfortunate news...")
		yield(DialogManager, "finished")
		DialogManager._create_dialog(self, "There's some wicked woman blocking the path home and  I need to get her out of here. This might help with some of it.")
		yield(DialogManager, "finished")
		player.item_acquired("Mace")
		return true
		
	else:
		return false
func notify():
	pass

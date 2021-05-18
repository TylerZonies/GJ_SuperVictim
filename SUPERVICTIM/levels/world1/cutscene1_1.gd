extends Node2D
onready var oboy = $oboy
onready var player = $player
var dialog_pos = Vector2(0,0)
signal dialog_finished()
var cutscene_begun = false
func _ready():
	$collision.visible = false
	$one_way_collision.visible = false
	
	dialog_pos = oboy.position
func begin_cutscene():
	cutscene_begun = true
	print("cutscene begun")
	$player.SPRITE.animation = "idle"
	$player.controls_disabled = true
	dialog(oboy, "You did pretty darn well back there.")
	yield(self, "dialog_finished")
	dialog(oboy, "There's someone that might be interested in some help. I know you are new around here.")
	yield(self, "dialog_finished")
	dialog(oboy, "I know you are interested in this offer. But it's gonna be some tough work.")
	yield(self, "dialog_finished")
	dialog(oboy, "Ahem... This fella is one of those types that think he the real boy.")
	yield(self, "dialog_finished")
	dialog_sound(oboy, "But we all know who the real boy is around this town. That's right. OoooO- Boy!", oboy.get_node("oboy"), 50)
	
	yield(self, "dialog_finished")
	
	player.controls_disabled = false
	player.mission_completed = true
func dialog(character, string):
	var cutscene_dialog = load("res://assets/objects/cutscene_dialog.tscn")
	cutscene_dialog = cutscene_dialog.instance()
	cutscene_dialog.text = string
	character.add_child(cutscene_dialog)
	yield(cutscene_dialog, "finished")
	character.remove_child(cutscene_dialog)
	emit_signal("dialog_finished")
func level_complete():
	SceneChanger.change_scene("res://levels/world1/world1_2.tscn", "World 1 - 2")
func dialog_sound(character, string, sound, sound_time):
	var cutscene_dialog = load("res://assets/objects/cutscene_dialog.tscn")
	cutscene_dialog = cutscene_dialog.instance()
	cutscene_dialog.text = string
	cutscene_dialog.sound = sound
	cutscene_dialog.sound_time = sound_time
	cutscene_dialog.play_sound = true
	character.add_child(cutscene_dialog)
	yield(cutscene_dialog, "finished")
	character.remove_child(cutscene_dialog)
	emit_signal("dialog_finished")

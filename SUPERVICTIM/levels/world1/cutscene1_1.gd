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
	dialog(oboy, "My dog Tim needs some help.")
	yield(self, "dialog_finished")
	dialog(oboy, "I know you are interested in this offer. But it's gonna be some tough work.")
	yield(self, "dialog_finished")
	dialog(oboy, "Maybe if you do this job for me, I can show you to another fella.")
	yield(self, "dialog_finished")
	dialog_sound(oboy, "Tough work requires tough pay, so I'll get you what you need in the mean time. OoooO- Boy!", oboy.get_node("oboy"), 50)
	
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

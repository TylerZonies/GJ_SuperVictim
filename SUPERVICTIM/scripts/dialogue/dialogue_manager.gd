extends Node

signal finished()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _create_dialog(character, text):
	var dialog_box = load("res://assets/objects/cutscene_dialog.tscn")
	dialog_box = dialog_box.instance()
	dialog_box.position = character.position
	add_child(dialog_box)
	dialog_box._dialog_box(text)
	yield(dialog_box, "finished")
	emit_signal("finished")

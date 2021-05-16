extends Node2D

var dialog = "Hey baby!"
var dialog_size = "small"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("npc")

func make_dialog():
	var dialog_box = load("res://assets/objects/dialog_box.tscn")

	dialog_box = dialog_box.instance()
	dialog_box.dialog = dialog
	dialog_box.size = dialog_size
	dialog_box.position = Vector2(-6,-4)

	add_child(dialog_box)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

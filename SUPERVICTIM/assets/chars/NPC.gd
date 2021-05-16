extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func make_dialog(dialog, dialog_size):
	if get_parent().is_talking == false:
		var dialog_box = load("res://assets/objects/dialog_box.tscn")

		dialog_box = dialog_box.instance()
		dialog_box.dialog = dialog
		dialog_box.size = dialog_size
		
		get_parent().add_child(dialog_box)
		dialog_box.position = Vector2(-6,-4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

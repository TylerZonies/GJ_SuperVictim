tool
extends Node2D


var ready = 0
onready var item_anim = get_node("item_anim")
export(String, "Skooner", "Key", "default") var item = "default"
var item_type = ""
func _ready():
	item_anim.play(item)
	add_to_group("item")

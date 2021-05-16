tool
extends Node2D


var ready = 0
onready var item_anim = get_node("item_anim")
export(String, "Skooner", "default") var item setget item_anim
func _ready():
	item_anim.play(item)
	add_to_group("item")
func item_anim(item):
	if Engine.editor_hint:
		get_node("item_anim").animation = str(item)


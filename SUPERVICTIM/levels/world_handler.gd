extends Node

var world_1 = ["world1_1", "world1_2"]
var world_index = [world_1]
var world_string = ["world1", "world2"]
var world_state = 0
var level_state = 0
func _ready():
	print(world_index[0][0])
	print(str(world_index[0]))
	load_level()

func load_level():
	var level = world_index[world_state][level_state]
	level = load(str("res://levels/",str(world_string[world_state]),"/",str(level), ".tscn"))
	level = level.instance()
	add_child(level)

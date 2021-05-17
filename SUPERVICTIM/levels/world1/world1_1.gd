extends Node2D
var controls_disabled = false


func _ready():
	$collision.visible = false
	$one_way_collision.visible = false
	 
func level_complete():
	var level_complete = load("res://scenes/level_complete.tscn")
	level_complete = level_complete.instance()
	add_child(level_complete)
	$player.controls_disabled = true

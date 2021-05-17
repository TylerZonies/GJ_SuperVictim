extends Node2D
var controls_disabled = false


func _ready():
	$collision.visible = false
	$one_way_collision.visible = false
	 
func level_complete():
	SceneChanger.change_scene("res://levels/world1/cutscene1_1.tscn", "Later that evening...")

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	change_collider_tiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func change_collider_tiles():
	var tile_map = $one_way_collision
	for i in tile_map.get_used_cells():
		tile_map.set_cellv(i, 6)

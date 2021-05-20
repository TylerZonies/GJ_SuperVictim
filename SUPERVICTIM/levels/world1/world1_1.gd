extends Node2D
var controls_disabled = false


func _ready():
<<<<<<< Updated upstream
	$collision.visible = false
	$one_way_collision.visible = false
	 
func level_complete():
	var level_complete = load("res://scenes/level_complete.tscn")
	level_complete = level_complete.instance()
	add_child(level_complete)
	$player.controls_disabled = true
=======
	change_collider_tiles()
	GlobalPlayer.player_node = $player

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func change_collider_tiles():
	var tile_map = $one_way_collision
	for i in tile_map.get_used_cells():
		tile_map.set_cellv(i, 6)
	$collision.visible = false
func knock_box():
	get_node("boxes/rosary").push_object(1)
>>>>>>> Stashed changes

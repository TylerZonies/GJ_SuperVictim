extends Node


var player_node = null
func _ready():
	pass 
func shake_camera(speed):
	player_node.total_time = 0
	player_node.camera_shake_speed = speed
	yield(get_tree().create_timer(1), "timeout")
	player_node.camera_shake_speed = 0

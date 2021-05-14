extends KinematicBody2D
var velocity = Vector2(0,0)
var fall_speed = 500
var x_direction = 0
var y_direction = 0

const UP = Vector2(0,-1)

func _physics_process(delta):
	get_input()
	

func get_input():
	var LEFT = Input.is_action_pressed('left')
	var RIGHT = Input.is_action_pressed('right')
	var UP = Input.is_action_pressed('up')
	var DOWN = Input.is_action_pressed('down')
	
	print(Input.is_action_pressed("right"))
	
	x_direction = -int(LEFT) + int(RIGHT)
	y_direction = -int(DOWN) + int(UP)
	print(x_direction)

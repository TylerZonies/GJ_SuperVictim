extends KinematicBody2D
var velocity = Vector2(0,0)
var fall_speed = 5
var x_direction = 0
var y_direction = 0

const UP = Vector2(0,-1)
const GROUND_SPEED = 10000

func _physics_process(delta):
	get_input(delta)
	#apply_gravity(delta)
	move_and_slide(velocity, UP)
	

func get_input(delta):
	var LEFT = Input.is_action_pressed('left')
	var RIGHT = Input.is_action_pressed('right')
	var UP = Input.is_action_pressed('up')
	var DOWN = Input.is_action_pressed('down')
	
	x_direction = -int(LEFT) + int(RIGHT)
	y_direction = -int(DOWN) + int(UP)
	move(x_direction, delta)

func apply_gravity(delta):
	velocity.y += fall_speed * delta
	

func move(direction, delta):
	velocity.x = direction * GROUND_SPEED * delta




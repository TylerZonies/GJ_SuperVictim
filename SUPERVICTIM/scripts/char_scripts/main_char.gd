extends KinematicBody2D
var velocity = Vector2(0,0)
var fall_speed = 250
var jump_speed = 5000
var x_direction = 0
var y_direction = 0
var sprite_dir = 1

const UP = Vector2(0,-1)
const GROUND_SPEED = 5000
onready var SPRITE = get_node("Sprite")
onready var platform_detector = get_node("platform_detector")
onready var floor_raycasts = get_node("floor_raycasts")

func _physics_process(delta):
	get_input(delta)
	apply_gravity(delta)
	move_and_slide(velocity, UP)
	

func get_input(delta):
	var LEFT = Input.is_action_pressed('left')
	var RIGHT = Input.is_action_pressed('right')
	var UP = Input.is_action_pressed('up')
	var DOWN = Input.is_action_pressed('down')
	
	x_direction = -int(LEFT) + int(RIGHT)
	y_direction = -int(DOWN) + int(UP)
	
	
	if x_direction != 0:
		if LEFT:
			SPRITE.flip_h = true
		elif RIGHT:
			SPRITE.flip_h = false
	
	move(x_direction, delta)
	

func apply_gravity(delta):
	if !check_on_floor():
		velocity.y += fall_speed * delta
	

func move(direction, delta):
	velocity.x = direction * GROUND_SPEED * delta

func check_on_floor():
	for raycast in floor_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func sprite_dir(dir):
	if dir == 1:
		SPRITE.flip_h = false
	else:
		SPRITE.flip_h = true

func jump(delta):
	if check_on_floor():
		velocity.y = -jump_speed * delta

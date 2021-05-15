extends KinematicBody2D
var velocity = Vector2(0,0)
var fall_speed = 350
var jump_speed = 11000
var x_direction = 0
var y_direction = 0
var sprite_dir = 1

const UP = Vector2(0,-1)
const GROUND_SPEED = 5000
onready var SPRITE = get_node("Sprite")
onready var platform_detector = get_node("platform_detector")
onready var floor_raycasts = get_node("floor_raycasts")
onready var side_raycast = get_node("object_detector")
func _physics_process(delta):
	get_input(delta)
	apply_gravity(delta)
	move_and_slide(velocity, UP)
	

func get_input(delta):
	var LEFT = Input.is_action_pressed('left')
	var RIGHT = Input.is_action_pressed('right')
	var UP = Input.is_action_pressed('up')
	var DOWN = Input.is_action_pressed('down')
	var PUSH = Input.is_action_pressed("push")
	x_direction = -int(LEFT) + int(RIGHT)
	y_direction = -int(DOWN) + int(UP)
	
	
	if x_direction != 0:
		if LEFT:
			SPRITE.flip_h = true
		elif RIGHT:
			SPRITE.flip_h = false
	
	if DOWN:
		#set_fall_through(false)
		position.y += 1
	if PUSH:
		push()
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
		side_raycast.rotation_degrees = -90
	else:
		SPRITE.flip_h = true
		side_raycast.rotation_degrees = 90

func jump(delta):
	if check_on_floor():
		velocity.y = -jump_speed * delta

func set_fall_through(set):
	print(set)
	set_collision_mask_bit(2, set)
	for raycast in floor_raycasts.get_children():
		raycast.set_collision_mask_bit(2, set)
	get_node("CollisionShape2D").disabled = true
	get_node("CollisionShape2D").disabled = false
	print(check_on_floor())
func push():   ## added push function for objects (i.e boxes n shit)
				## checks for object, gets its parent and asks if its moveable
	var collider = side_raycast.get_collider()
	
	if collider != null:
		collider = collider.get_parent()
		if collider.is_in_group("moveable"):
			if collider.moveable == true:
				print("i can move this box!")
				collider.push_object()

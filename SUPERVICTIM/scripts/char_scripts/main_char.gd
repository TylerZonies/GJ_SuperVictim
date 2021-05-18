extends KinematicBody2D
var velocity = Vector2(0,0)
var fall_speed = 350
var jump_speed = 10750
var x_direction = 0
var y_direction = 0
var sprite_dir = 1

var controls_disabled = false
var mission_completed = true


var items_held = []

const UP = Vector2(0,-1)
const GROUND_SPEED = 5000
onready var SPRITE = get_node("Sprite")
onready var platform_detector = get_node("platform_detector")
onready var floor_raycasts = get_node("floor_raycasts")
onready var side_raycast = get_node("object_detector")
onready var walk_sfx = get_node("walk_sfx")
func _physics_process(delta):
	if !controls_disabled:
		get_input(delta)
	else:
		velocity = Vector2(0,0)
		x_direction = 0
		y_direction = 0
		
	apply_gravity(delta)
	move_and_slide(velocity, UP)
	

func get_input(delta):
	var LEFT = Input.is_action_pressed('left')
	var RIGHT = Input.is_action_pressed('right')
	var UP = Input.is_action_pressed('up')
	var DOWN = Input.is_action_pressed('down')
	var PUSH = Input.is_action_just_pressed("push")
	x_direction = -int(LEFT) + int(RIGHT)
	y_direction = -int(DOWN) + int(UP)
	
	
	if x_direction != 0:
		if LEFT:
			SPRITE.flip_h = true
		elif RIGHT:
			SPRITE.flip_h = false
	
	if Input.is_action_just_released("up") and velocity.y < -1000:
		velocity.y = -1000
	
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
		audio_player("jump_sfx")

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
				collider.push_object(x_direction)
				SPRITE.play("push")
		if collider.is_in_group("npc"):
			SPRITE.play("wave")
			collider.make_dialog()

			print(collider)
		if collider.is_in_group("item"):
			item_acquired(collider)
			collider.queue_free()
			

func item_acquired(item_node):
	var item_dialog = load("res://assets/objects/item_dialog.tscn")
	item_dialog = item_dialog.instance()
	item_dialog.item = str(item_node.item)
	item_dialog.position.y += -24
	add_child(item_dialog)
	items_held.append(item_node.item)
	print(items_held)
	
	start_timer()
	SPRITE.play("item_obtain")
	
func _has_item(item:String):
	if items_held.has(item):
		return true
func audio_player(sfx_str):
	var sound = get_node(str(sfx_str))
	walk_sfx.playing = false
	sound.playing = false
	sound.playing = true
func start_timer():
		x_direction = 0
		y_direction = 0
		controls_disabled = true
		$wait_timer.start()
func _on_wait_timer_timeout():
	controls_disabled = false

extends Node2D

var moveable = true
var velocity = Vector2(0,0)
var obj_moved = false
var fall_speed = 10
var max_fall_speed = 50
const UP = Vector2(0,-1)



onready var floor_cast = get_node("box_obj/floorcast")
onready var body = get_node("box_obj")


onready var cast_right = get_node("box_obj/right")
onready var cast_left = get_node("box_obj/left")
onready var cast_up = get_node("box_obj/up")

var raycasts

func _ready():
	self.add_to_group("moveable")
	raycasts = [cast_right, cast_left, cast_up]
func _process(delta):
	apply_gravity(delta)
	position += velocity
func push_object(dir, pushed = false):
	var collisions = check_collider()
	if collisions.size() == 0:
		move(dir)
	else:
		for collision in collisions:
			match collision.dir:
				"left","right":
					print('in left right')
					if collision.obj.check_double_push(collision.dir):
						print('~~~~~~~~~~~~~~~~~~~~~~~~~~')
						print('collision obj')
						print(collision.obj)
						print('~~~~~~~~~~~~~~~~~~~~~~~~~~')
						collision.obj.move(dir)
					
				"up":
					return

func move(dir):
	position.x += dir

func check_double_push(dir):
	
	var my_bool = true
	var collisions = check_collider()
	
	for collision in collisions:
		if collision.dir == "up" or collision.dir == dir:
			my_bool = false
	
	print('check double')
	print(my_bool)
	return my_bool

func check_on_floor():
	if floor_cast.is_colliding():
		return true
	#else:
		#moveable = false
		#return false

func apply_gravity(delta):
	if !check_on_floor():
		if velocity.y < max_fall_speed:
			velocity.y += fall_speed * delta
		else:
			velocity.y = max_fall_speed
	else: 
		velocity.y = 0

func check_collider():
	var collisions = []
	for i in raycasts.size():
		if raycasts[i].is_colliding():
			var obj = raycasts[i].get_collider()
			if obj.get_parent().is_in_group("moveable"):
				collisions.append({"obj": obj.get_parent(), "dir": raycasts[i].name})
				
	return collisions




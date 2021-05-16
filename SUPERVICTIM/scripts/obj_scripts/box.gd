extends Node2D

var moveable = true
var velocity = Vector2(0,0)
var obj_moved = false
const UP = Vector2(0,-1)


var new_pos = Vector2.ZERO
var direction = 0
var fall_dir = 0

var speed = 1
##############################################################

var raycasts


onready var floor_cast = get_node("box_obj/floorcast")
onready var body = get_node("box_obj")


onready var cast_right = get_node("box_obj/right")
onready var cast_left = get_node("box_obj/left")
onready var cast_up = get_node("box_obj/up")
onready var sprite = get_node("box_obj/box")



##############################################################
func _ready():
	self.add_to_group("moveable")
	raycasts = [cast_right, cast_left, cast_up]
func _process(delta):
	if !_is_moving():
		apply_gravity(delta)
		
		
##############################################################
func push_object(dir, pushed = false):
	var collisions = check_collider()
	if collisions.size() == 0:
		move(dir)
		audio_player("roll_sfx")
	else:
		for collision in collisions:
			match collision.dir:
				"left","right":
					#print('in left right')
					if collision.obj.check_double_push(collision.dir):
						#print('~~~~~~~~~~~~~~~~~~~~~~~~~~')
						#print('collision obj')
						#print(collision.obj)
						#print('~~~~~~~~~~~~~~~~~~~~~~~~~~')
						collision.obj.move(dir)
						move(dir)
						audio_player("roll_sfx")
					
				"up":
					return

func move(dir):
	var new_dir = Vector2(position.x + (dir * 16), position.y)
	new_pos = new_dir
	direction = dir

func _is_moving():
	if new_pos != Vector2.ZERO:
		if position != new_pos:
			position.x += speed * direction
			position.y += speed * fall_dir
			sprite.rotation_degrees += 5 * speed
			moveable = false
			return true
		else:
			new_pos = Vector2.ZERO
			direction = 0
			fall_dir = 0
			moveable = true
			
			return false
		
func check_double_push(dir):
	
	var my_bool = true
	var collisions = check_collider()
	
	for collision in collisions:
		if collision.dir == "up" or collision.dir == dir:
			my_bool = false
	
	#print('check double')
	#print(my_bool)
	return my_bool

func check_on_floor():
	if floor_cast.is_colliding():
		sprite.rotation_degrees = 90
		return true

	#else:
		#moveable = false
		#return false

func apply_gravity(delta):
	pass
	if !check_on_floor():
		new_pos = Vector2(position.x, position.y + 16)
		fall_dir = 1
#		if velocity.y < max_fall_speed:
#			velocity.y += fall_speed * delta
#		else:
#			velocity.y = max_fall_speed
#	else: 
#		velocity.y = 0

func check_collider():
	var collisions = []
	for i in raycasts.size():
		if raycasts[i].is_colliding():
			var obj = raycasts[i].get_collider()
			if obj.get_parent().is_in_group("moveable"):
				collisions.append({"obj": obj.get_parent(), "dir": raycasts[i].name})
				
	return collisions

func audio_player(sfx_str):
	var sound = get_node(str(sfx_str))
	sound.playing = false
	sound.playing = true


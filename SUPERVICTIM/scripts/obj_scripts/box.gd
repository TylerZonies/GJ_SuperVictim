extends Node2D

var moveable = true
var velocity = Vector2(0,0)
var obj_moved = false
var fall_speed = 10
const UP = Vector2(0,-1)


onready var floor_cast = get_node("box_obj/floorcast")
onready var body = get_node("box_obj")
	

func _ready():
	self.add_to_group("moveable")
func _process(delta):
	apply_gravity(delta)
	position += velocity
func push_object(dir):
	position.x += dir

func check_on_floor():
	if floor_cast.is_colliding():
		return true
	else:
		moveable = false
		return false

func apply_gravity(delta):
	if !check_on_floor():
		velocity.y += fall_speed * delta
	else: 
		velocity.y = 0
	




extends Node2D

var moveable = true
var velocity = Vector2(0,0)
var obj_moved = false
var fall_speed = 10
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
func push_object(dir):
	
	check_collider(dir)
func move(dir):
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
func check_collider(dir):
	for i in raycasts.size():
		if raycasts[i].is_colliding():
			var obj = raycasts[i].get_collider()
			if obj.get_parent().is_in_group("moveable"):
				if raycasts[i].name == "left" or raycasts[i].name == "right":
					obj.get_parent().move(dir)
					move(dir)




extends Node2D

var moveable = true
var velocity = Vector2(0,0)
var obj_moved = false
var fall_speed = 10
const UP = Vector2(0,-1)


onready var raycasts = get_node("box_obj/raycasts")
onready var floor_cast = get_node("box_obj/floorcast")
onready var body = get_node("box_obj")
	

func _ready():
	self.add_to_group("moveable")
func _process(delta):
	apply_gravity(delta)
	position += velocity
func push_object(dir):
	position.x += dir
	check_collider()
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
func check_collider():
	for i in raycasts.get_children():
		if i.is_colliding():
			var obj = i.get_collider()
			if obj.get_parent() != body:
				if obj.get_parent().is_in_group("moveable"):
					print(obj)




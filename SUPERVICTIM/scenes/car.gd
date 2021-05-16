extends Node2D

var sprite_pos = [[0, false],[-16, true],[0, false],[0, true]]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var right_side = get_node("car_right").position
onready var left_side = get_node("car_left").position
var time = 0
var timer = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if time < timer:
		time += 1
	else:
		time = 0
		var random = randi()%3
		var direction = randi()%2
		var car = load("res://assets/objects/car.tscn")
		car = car.instance()
		car.commit_sprite(random, sprite_pos[random])
		
		match direction: # 0 is right side 1 is left side
			0:
				car.position = right_side
				car.death_position = left_side
				car.direction = -1
			1:
				car.position = left_side
				car.death_position = right_side
				car.direction = 1
		add_child(car)
		print(direction)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

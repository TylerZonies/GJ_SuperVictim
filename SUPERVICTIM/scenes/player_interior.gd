extends KinematicBody2D
var x_direction = 0
var y_direction = 0
var last_known = Vector2(0,0)
var speed = 0
var tick = 0
var relativeVector = Vector2(0, 0)
enum states {WALK, IDLE}
var state = states.WALK
var sound_playing = false
var controls_disabled = false
onready var SPRITE = get_node("AnimatedSprite")
onready var walk_sound = get_node("walk")
onready var area = get_node("Area2D")
func _ready():
	last_known = position
func _tick(delta):
	if tick == 0:
		tick = 1
	else:
		tick = 0
func _process(delta):
	if !controls_disabled:
		get_input()
		speed = tick * 2
		_tick(delta)
func get_input():
	var LEFT = Input.is_action_pressed('left')
	var RIGHT = Input.is_action_pressed('right')
	var UP = Input.is_action_pressed('up')
	var DOWN = Input.is_action_pressed('down')
	var PUSH = Input.is_action_just_pressed("push")
	x_direction = -int(LEFT) + int(RIGHT)
	y_direction = +int(DOWN) - int(UP)
	if x_direction != 0:
		if LEFT:
			SPRITE.flip_h = true
		elif RIGHT:
			SPRITE.flip_h = false
		SPRITE.animation = "walk"
		sound_manager(true)
		
		y_direction = 0
	elif y_direction != 0:
		if UP:
			SPRITE.animation = "walk_up"
		elif DOWN:
			SPRITE.animation = "walk_down"
		x_direction = 0
		sound_manager(true)
		
	if x_direction == 0 && y_direction == 0:
		SPRITE.frame = 0
		sound_manager(false)
	if PUSH:
		print("pushing")
		check_collider()
	relativeVector = Vector2(x_direction*speed, y_direction*speed)
	move_and_collide(relativeVector)
func sound_manager(boolean):
	if boolean:
		if !walk_sound.is_playing():
			walk_sound.playing = true
	else:
		walk_sound.playing = false
func check_collider():
	var areas = area.get_overlapping_areas()
	for i in areas.size():
		match areas[i].name:
			"computer":
				var computer = load("res://scenes/computer_ui.tscn")
				sound_manager(false)
				computer = computer.instance()
				computer.position.x -= 9
				get_parent().add_child(computer)
				controls_disabled = true
				yield(computer, "closed")
				controls_disabled = false
				

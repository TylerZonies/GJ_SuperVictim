extends Node2D

var death_position = Vector2.ZERO
var direction = 0
const speed = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0
var timer = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = randi()%10
	timer = rand * timer
	scale.x = direction * -1
	$AudioStreamPlayer2D.pitch_scale = rand_range(0.5, 0.9)

func _process(delta):
	match direction:
		1:
			if position.x > death_position.x:
				queue_free()
		-1:
			if position.x < death_position.x:

				queue_free()
	misfire()
	position.x += direction * speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func commit_sprite(random, sprite_pos):
	$cars.animation = str("car", random)
	print(sprite_pos)
	$cars.flip_h = sprite_pos[1]
	$cars.position.y += sprite_pos[0]
func misfire():
	
	if time < timer:
		time += 1
	else:
		$mis_fire.playing = false
		$mis_fire.playing = true
		time = 0

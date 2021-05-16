extends Node2D

var death_position = Vector2.ZERO
var direction = 0
const speed = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	scale.x = direction * -1

func _process(delta):
	match direction:
		1:
			if position.x > death_position.x:
				queue_free()
		-1:
			if position.x < death_position.x:

				queue_free()

	position.x += direction * speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func commit_sprite(random, sprite_pos):
	$cars.animation = str("car", random)
	print(sprite_pos)
	$cars.flip_h = sprite_pos[1]
	$cars.position.y += sprite_pos[0]

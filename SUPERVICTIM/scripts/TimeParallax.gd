extends ParallaxBackground

var speed = 5
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var clouds = get_node("clouds")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	clouds.motion_offset.x += delta * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

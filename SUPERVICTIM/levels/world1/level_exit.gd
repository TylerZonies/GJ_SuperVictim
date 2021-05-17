extends Node2D

onready var body = get_node("Area")
func _ready():
	pass 
	


func _on_Area_body_entered(body):
	print(body.name)
	if body.name == "player":
		if body.mission_completed:
			get_parent().level_complete()

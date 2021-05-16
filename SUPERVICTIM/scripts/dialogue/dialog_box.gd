extends Node2D
var dialog = ""
var size = ""
var time = 0
var is_deleting = false

func _ready():
	get_parent().is_talking = true
	match size:
		"big":
			$AnimationPlayer.play("dialog_big")
			$text_big.text = dialog
			time = 5
		"small":
			$AnimationPlayer.play("dialog_small")
			$text_small.text = dialog
			time = 2
			print("im here", size)
	$Timer.wait_time = time
	$Timer.start()
	


func _on_Timer_timeout():
	if !is_deleting:
		$Timer.wait_time = 2
		$AnimationPlayer.play_backwards()
		is_deleting = true
		$Timer.start()
		get_parent().is_talking = false
		
	else:
		queue_free()

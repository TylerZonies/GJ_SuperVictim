extends CanvasLayer

onready var replay_btn = get_node("Control/Replay")
onready var home_btn = get_node("Control/Home")
onready var next_btn = get_node("Control/Next Level")

onready var btn_array = [replay_btn, home_btn, next_btn]
var btn_press = ["Replay", "Home", "Proceed"]
signal button_pressed(btn_string)
var btn_index = 0
func _ready():
	pass 
func _process(delta):
	var LEFT = Input.is_action_just_pressed('left')
	var RIGHT = Input.is_action_just_pressed('right')
	var PUSH = Input.is_action_just_released("push")
	btn_array[btn_index].grab_focus()
	
	if LEFT:
		if btn_index == 0:
			btn_index = btn_array.size() - 1
		else:
			btn_index += -1
	if RIGHT:
		if btn_index == btn_array.size() - 1:
			btn_index = 0
		else:
			btn_index += 1
	if PUSH:
		btn_array[btn_index]
		emit_signal(btn_press[btn_index])
	

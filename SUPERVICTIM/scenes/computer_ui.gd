extends Node2D

onready var date_time = get_node("computer_ui/MarginContainer/date_time")
onready var control = get_node("computer_ui")
onready var left_menu = get_node("computer_ui/main_menu/VBoxContainer")
onready var animation = get_node("animation")
var left_right_main = []
var option_labels = []
var main = []
var index = 0
var up_down_nav = true
var curr_menu = null
var rebinding = false
var remap_action = ""
signal closed()
func _ready():
	_initiate()
	option_labels()
	current_menu(left_menu)
	get_focus(main[0])

func _process(delta):
	var os_date = OS.get_datetime()
	date_time.text = str(os_date['month'], "/", os_date['day'], "/", os_date['year'], " ", 
						os_date['hour'], ":", os_date['minute'], ":", os_date['second'])
func get_focus(btn):
	btn.grab_focus()
func _input(event):
	if !check_remap(event):
		var LEFT = Input.is_action_just_pressed('left')
		var RIGHT = Input.is_action_just_pressed('right')
		var UP = Input.is_action_just_pressed('up')
		var DOWN = Input.is_action_just_pressed('down')
		var PUSH = Input.is_action_just_pressed("push")
		if up_down_nav:
			if DOWN:
				next_focus(main)
				$select.play()
			if UP:
				prev_focus(main)
				$select.play()
		if PUSH:
			btn_action(main[index].name)
			main[index].pressed = true
			$click.play()
func current_menu(node):
	main.clear()
	for i in node.get_children():
		main.append(i)
		print(i)
	get_focus(main[0])
	index = 0

func next_focus(btn_array):
	if index < btn_array.size() - 1:
		index += 1
		get_focus(btn_array[index])
		
	else:
		index = 0
		get_focus(btn_array[index])
func prev_focus(btn_array):
	if index <= btn_array.size() - 1 && index > 0:
		index -= 1
		get_focus(btn_array[index])
		
	else:
		index = btn_array.size()-1
		get_focus(btn_array[index])
func btn_action(btn_name):
	match btn_name:
		"Profile":
			$Profile.rect_position = $Position2D.position
			current_menu($Profile.get_node("btns"))
			curr_menu = $Profile
		"NewGame":
			new_game()
		"Back":
			curr_menu.rect_position = $Clear.position
			current_menu(left_menu)
		"Options":
			$Options.rect_position = $Position2D.position
			current_menu($Options.get_node("Keybind_Menu/MarginContainer/HBoxContainer/Btns"))
			curr_menu = $Options
			main.append($Options/Keybind_Menu/Back)
		"up","down","left","right","push":
			rebinding = true
			remap_action = btn_name
			option_labels[index].text = "Remap"
		"Exit":
			_close()
func check_remap(event):
	if rebinding == true:
		if event is InputEventKey and event.pressed:
			print(event.scancode)
			InputMap.action_erase_events(remap_action)
			InputMap.action_add_event(remap_action, event);
			option_labels[index].text = str(event.scancode)
			rebinding = false
			main[index].pressed = false
			return true
	else:
		return false
		
	
func option_labels():
	for i in $Options/Keybind_Menu/MarginContainer/HBoxContainer/Controls.get_children():
		option_labels.append(i)
func _initiate():
	$computer_ui.visible = false
	animation.play("screen_popup")
	yield(animation, "animation_finished")
	$good_morning.play()
	yield(get_tree().create_timer(1), "timeout")
	$computer_ui.visible = true
func _close():
	$computer_ui.visible = false
	$car_horn.play()
	animation.play("screen_exit")
	yield(animation, "animation_finished")
	emit_signal("closed")
	queue_free()
func new_game():
	$computer_ui.visible = false
	$car_horn.play()
	animation.play("screen_exit")
	yield(animation, "animation_finished")
	emit_signal("closed")
	SceneChanger.change_scene("res://levels/world1/world1_1.tscn", "Introduction")
	queue_free()

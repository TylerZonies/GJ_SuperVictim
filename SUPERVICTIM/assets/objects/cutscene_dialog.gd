extends Node2D

var text = ""
onready var dialog_text = $text
onready var sprite_next = $next
onready var animation = $dialog_anim

onready var vocal_c = $vocal_c
onready var vocal_e = $vocal_e
onready var vocal_o = $vocal_o
var play_sound = false
var sound = null
var vox
var sound_time = 2
var dialog_completed = false
var delete_text = false
var text_speed = 0.02
signal finished()
signal string_displayed()
func _ready():
	vox = [vocal_c,vocal_e,vocal_o]
	dialog_text.visible_characters = 0
	dialog_text.text = text
	sprite_next.visible = false
	animation.play("dialog")
	$dialog_open.play()
	yield(animation, "animation_finished")
	display_characters()
	yield(self, "string_displayed")
	dialog_completed = true
	sprite_next.visible = true
	yield(self, "string_displayed")
	remove_characters()
	yield(self, "string_displayed")
	animation.play_backwards()
	yield(animation, "animation_finished")
			
	emit_signal("finished")
	queue_free()
func _process(delta):
	if dialog_completed && !delete_text:
		if Input.is_action_just_pressed("push"):
			sprite_next.modulate = Color(0.5,0.5,0.5,1)
			$dialog_open.play()
			yield(get_tree().create_timer(0.1), "timeout")
			
			sprite_next.visible = false
			emit_signal("string_displayed")
			delete_text =true


func display_characters():
	if dialog_text.visible_characters < dialog_text.text.length():
		dialog_text.visible_characters += 1
		vox[randi()%2].play()
		yield(get_tree().create_timer(text_speed), "timeout")
		if play_sound == true && dialog_text.visible_characters == sound_time:
			play_sound()
			play_sound = false
		display_characters()
	else:
		emit_signal("string_displayed")
func remove_characters():
	if dialog_text.visible_characters > 0:
		dialog_text.visible_characters -= 1
		yield(get_tree().create_timer(text_speed*0.1), "timeout")
		remove_characters()
	else:
		emit_signal("string_displayed")
func play_sound():
	sound.play()

extends CanvasLayer

signal scene_changed()
signal string_displayed()
onready var animation_player = $AnimationPlayer
onready var black = $Control/ColorRect
onready var world_text = $world_text
onready var vox_a = $vox_a
onready var vox_b = $vox_b
onready var vox_c = $vox_c
onready var sprite = $sprite
var vox
func _ready():
	world_text.visible_characters = 0
	vox = [vox_a,vox_b,vox_c]
func change_scene(path,string, delay = 0.5):
	world_text.visible_characters = 0
	world_text.text = string
	var text_length = string.length()
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	display_characters()
	yield(self, "string_displayed")
	remove_characters()
	yield(self, "string_displayed")
	animation_player.play_backwards("fade")
	emit_signal("scene_changed")
func display_characters():
	if world_text.visible_characters < world_text.text.length():
		world_text.visible_characters += 1
		vox[randi()%2].play()
		yield(get_tree().create_timer(0.1), "timeout")
		display_characters()
	else:
		emit_signal("string_displayed")
func remove_characters():
	if world_text.visible_characters > 0:
		world_text.visible_characters -= 1
		yield(get_tree().create_timer(0.1), "timeout")
		remove_characters()
	else:
		emit_signal("string_displayed")

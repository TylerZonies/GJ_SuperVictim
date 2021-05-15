extends StateMachine

func _ready():
	
	add_state('idle')
	add_state('walk')
	add_state('jump')
	add_state('fall')
	call_deferred('set_state', states.idle)
	print(states)

func _state_logic(delta):
	if parent.y_direction == 1:
		parent.jump(delta)

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.check_on_floor():
				return states.jump
			elif parent.x_direction !=0:
				return states.walk
		states.walk:
			if !parent.check_on_floor():
				return states.jump
			elif parent.x_direction == 0:
				return states.idle
			elif parent.y_direction == 1:
				return states.jump
		states.jump:
			if parent.check_on_floor():
				return states.idle

func _enter_state(old_state, new_state):
	print(new_state)
	match new_state:
		states.idle:
			parent.SPRITE.animation = 'idle'
		states.walk:
			parent.sprite_dir(parent.x_direction)
			print(parent.x_direction)
			parent.SPRITE.animation = 'walk'
		states.jump:
			parent.SPRITE.animation = 'jump'

func _exit_state(old_state, new_state):
	pass

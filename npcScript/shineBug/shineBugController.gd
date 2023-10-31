extends Node

var _target

var max_speed
var min_speed


var right_dir_angles = [0,-25,25]
var left_dir_angles = [-155,-180,-205]
var up_dir_angles = [-50,-90,-130]
var down_dir_angles = [50,90,130]

var directions = ["left","right","up","down"]
var current_direction

var MoveState
var state_machine

var move_left_state
var move_right_state
var move_up_state
var move_down_state

var boundries = OS.get_window_size()

func _load_vars():
	max_speed = _target.MaxSpeed
	min_speed = _target.MinSpeed

func create_dir_state(state_name,angles):
	var _state = MoveState.new()
	_state.set_target_node(_target)
	_state.set_name(state_name)
	_state.set_angles(angles)
	_state.set_state_machine(state_machine)
	return _state


func _load_states():
	MoveState = load("res://npcScript/shineBug/states/move.gd")
	state_machine = load("res://npcScript/shineBug/state_machine/state_machine_interface.gd").new()
	
	move_left_state = create_dir_state("move_left",left_dir_angles)
	
	move_right_state = create_dir_state("move_right",right_dir_angles)
	
	move_up_state = create_dir_state("move_up",up_dir_angles)
	
	move_down_state = create_dir_state("move_down",down_dir_angles)
	
	state_machine.add_state_to_table(move_right_state,[move_right_state,move_up_state,move_left_state,move_down_state],true)
	state_machine.add_state_to_table(move_left_state,[move_right_state,move_up_state,move_left_state,move_down_state])
	state_machine.add_state_to_table(move_up_state,[move_right_state,move_up_state,move_left_state,move_down_state])
	state_machine.add_state_to_table(move_down_state,[move_right_state,move_up_state,move_left_state,move_down_state])

func set_target(target):
	_target = target
	_load_vars()
	_load_states()
	
func _ready():
	_target = get_parent()
	_load_vars()
	_load_states()

func _physics_process(delta):
#	print("processing")
	if _target.position.x>boundries.x-32:
		$long_term_moves.start()
		current_direction = "left"
		state_machine.transistion_to_state("move_left")
	if _target.position.x<32:
		$long_term_moves.start()
		current_direction = "right"
		state_machine.transistion_to_state("move_right")
	if _target.position.y>boundries.y-32*8:
		$long_term_moves.start()
		current_direction = "up"
		state_machine.transistion_to_state("move_up")
	if _target.position.y<32:
		$long_term_moves.start()
		current_direction = "down"
		state_machine.transistion_to_state("move_down")
	state_machine.physics_process(delta)


func _on_short_term_move_timeout():
	if current_direction == "left":
		
		state_machine.transistion_to_state("move_left")
		return
		
	if current_direction == "right":
		
		state_machine.transistion_to_state("move_right")
		return
		
	if current_direction == "up":
		state_machine.transistion_to_state("move_up")
		return
		
	if current_direction == "down":
		state_machine.transistion_to_state("move_down")
		return

func _on_long_term_moves_timeout():
	var dir = directions[floor(rand_range(0,len(directions)))]
	randomize()
	var probability = randf()
	if probability<0.8:
		if dir == "left":
			var flip_probability = randf()
			if flip_probability<0.9:
				_target.get_node("Sprite").set_flip_h(false)
			else:
				_target.get_node("Sprite").set_flip_h(true)
			current_direction = "left"
			state_machine.transistion_to_state("move_left")
			return
			
		if dir == "right":
			var flip_probability = randf()
			if flip_probability<0.9:
				_target.get_node("Sprite").set_flip_h(true)
			else:
				_target.get_node("Sprite").set_flip_h(false)
			current_direction = "right"
			state_machine.transistion_to_state("move_right")
			return
	else:	
		if dir == "up":
			current_direction = "up"
			state_machine.transistion_to_state("move_up")
			return
			
		if dir == "down":
			current_direction = "down"
			state_machine.transistion_to_state("move_down")
			return
			
	


func _on_flip_timeout():
	_target.get_node("Sprite").set_flip_h(!_target.get_node("Sprite").flip_h)
	pass # Replace with function body.


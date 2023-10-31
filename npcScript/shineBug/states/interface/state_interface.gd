extends Object

var _name
var _target:KinematicBody2D
var _state_machine:StateMachine

func set_state_machine(machie):
	_state_machine = machie

func set_name(name):
	_name = name

func get_name():
	return _name

func set_target_node(traget_node):
	_target = traget_node

func get_target_node():
	return _target
	
func enter(arg):
	pass
	

func update(delta):
	pass

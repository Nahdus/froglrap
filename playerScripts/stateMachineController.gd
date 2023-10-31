extends Node


var target
var StateMachineInterface = preload("res://playerScripts/frogSkeleton/state_machine/state_machine_interface.gd")

var IdleStste = preload("res://playerScripts/frogSkeleton/states/idle.gd")
var LowJumpStste = preload("res://playerScripts/frogSkeleton/states/low_jump.gd")
var HighJumpStste = preload("res://playerScripts/frogSkeleton/states/high_jump.gd")
var deathState = preload("res://playerScripts/frogSkeleton/states/death_state.gd")

var state_machine_interface:StateMachine

var idle_state
var low_jump_state
var high_jump_state
var death_state

func create_state(state_name,state):
	var _state = state.new()
	_state.set_target_node(target)
	_state.set_name(state_name)
	_state.set_state_machine(state_machine_interface)
	return _state

func _ready():
	state_machine_interface = StateMachineInterface.new()
	target = get_parent()
	idle_state = create_state("idle_state",IdleStste)
	high_jump_state = create_state("high_jump_state",HighJumpStste)
	low_jump_state = create_state("low_jump_state",LowJumpStste)
	death_state = create_state("death_state",deathState)
	state_machine_interface.add_state_to_table(idle_state,[low_jump_state,high_jump_state,death_state],true)
	state_machine_interface.add_state_to_table(low_jump_state,[idle_state,death_state])
	state_machine_interface.add_state_to_table(high_jump_state,[idle_state,death_state])
	state_machine_interface.add_state_to_table(death_state,[])
	

func _physics_process(delta):
	state_machine_interface.physics_process(delta)

func die(_death_type):
	state_machine_interface.transistion_to_state("death_state")
	print_debug("dead")
	

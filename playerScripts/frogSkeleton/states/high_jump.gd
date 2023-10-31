extends "res://playerScripts/frogSkeleton/states/interface/state_interface.gd"



var _dir

var high_jump_horizontal_speed
var high_jump_vertical_speed
var high_jump_gravity
var just_entered = false

func _ready():
	set_name("high_jump")
	
func time_out():
	just_entered = false
	
func enter(arg):
	_target.get_node("largejumpsfx").play()
	just_entered = true
	_dir = arg
	high_jump_horizontal_speed = _target.high_jump_horizontal_speed 
	high_jump_vertical_speed = _target.high_jump_vertical_speed 
	high_jump_gravity = _target.high_jump_gravity
	_target.count_time(0.5,self,"time_out")
	
func update(delta):
#	_state_machine.transistion_to_state("idle_state")
#	if just_entered:
	high_jump_vertical_speed = high_jump_vertical_speed - high_jump_gravity*delta
	_target.move_and_slide(Vector2(_dir*high_jump_horizontal_speed,high_jump_vertical_speed),Vector2.UP)
	
	if 	_target.floor_detected() and not just_entered:
		_state_machine.transistion_to_state('idle_state')

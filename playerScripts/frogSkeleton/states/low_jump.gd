extends "res://playerScripts/frogSkeleton/states/interface/state_interface.gd"

var _dir

var low_jump_horizontal_speed
var low_jump_vertical_speed
var low_jump_gravity
var just_entered = false

func _ready():
	set_name("low_jump")
	
func time_out():
	just_entered = false
	
func enter(arg):
	_target.get_node("smalljumpsfx").play()
	just_entered = true
	_dir = arg
	low_jump_horizontal_speed = _target.low_jump_horizontal_speed 
	low_jump_vertical_speed = _target.low_jump_vertical_speed 
	low_jump_gravity = _target.low_jump_gravity
	_target.count_time(0.5,self,"time_out")
	
func update(delta):
#	_state_machine.transistion_to_state("idle_state")
#	if just_entered:
	low_jump_vertical_speed = low_jump_vertical_speed - low_jump_gravity*delta
	_target.move_and_slide(Vector2(_dir*low_jump_horizontal_speed,low_jump_vertical_speed),Vector2.UP)
	
	if 	_target.floor_detected() and not just_entered:
		_state_machine.transistion_to_state('idle_state')

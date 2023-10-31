extends "res://playerScripts/frogSkeleton/states/interface/state_interface.gd"

var height = 30
var time = 3

var gravity = -(2*height)/pow((time/2),2)
var vertical_speed = gravity*(time/2)

func compute_physics_vars():
	gravity = -(2*height)/pow((time/2),2)
	vertical_speed = 0.0

func _ready():
	
	set_name("idle")
	

func enter(arg):
	time = 0.5
	compute_physics_vars()
	
	
func get_input():
	return {
		"low_jump_right":Input.is_action_pressed("low_jump_right"),
		"low_jump_left":Input.is_action_pressed("low_jump_left"),
		"high_jump_right":Input.is_action_pressed("high_jump_right"),
		"high_jump_left":Input.is_action_pressed("high_jump_left")
	}
	
func update(delta):
	vertical_speed = vertical_speed-gravity*delta
	var velocity = Vector2(0,vertical_speed)
	velocity = _target.move_and_slide(velocity,Vector2.UP)
	if get_input()["low_jump_right"]:
		_state_machine.transistion_to_state("low_jump_state",1.0)
	if get_input()["low_jump_left"]:
		_state_machine.transistion_to_state("low_jump_state",-1.0)
	if get_input()["high_jump_right"]:
		_state_machine.transistion_to_state("high_jump_state",1.0)
	if get_input()["high_jump_left"]:
		_state_machine.transistion_to_state("high_jump_state",-1.0)


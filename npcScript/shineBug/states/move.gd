extends "res://npcScript/shineBug/states/interface/state_interface.gd"



var _angles
var current_angle
var _max_speed
var _min_speed
var current_speed

func set_state_name(name):
	set_name(name)
	
func set_angles(angles):
	_angles = angles
	
	
func load_vars():
	_max_speed = _target.MaxSpeed
	_min_speed = _target.MinSpeed
	randomize()
	current_speed = rand_range(_min_speed,_max_speed*0.4)
	randomize()
	current_angle = _angles[floor(rand_range(0,len(_angles)))]
	
func enter(arg):
	load_vars()
#	set_angles(_angles)
	
	
	
	
func update(delta):
#	print("moving")
	_target.move_and_slide(Vector2(current_speed*cos((PI/180)*current_angle),current_speed*sin((PI/180)*current_angle)))
	

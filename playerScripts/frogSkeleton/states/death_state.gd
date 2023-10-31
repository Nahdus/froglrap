extends "res://playerScripts/frogSkeleton/states/interface/state_interface.gd"



var _dir =1.0

var death_horizontal_speed
var death_vertical_speed
var death_gravity
var just_entered = false

func _ready():
	set_name("death")
	
func time_out():
	just_entered = false
	
func enter(arg):
	if _target.position.y>620:
		_target.get_node("drowning").play()
	_target.get_node("CollisionShape2D").set_disabled(true)
	_target.set_collision_mask_bit(1,false)
	_target.set_collision_layer_bit(0,false)
	just_entered = true
	death_horizontal_speed = _target.death_horizontal_speed 
	death_vertical_speed = _target.death_vertical_speed 
	death_gravity = _target.death_gravity
	_target.rotation_degrees = 180.0
	
	
func update(delta):
	_target.move_and_slide(Vector2(_dir*death_horizontal_speed,death_vertical_speed),Vector2.UP)
	if _target.position.y>1000:
		_target.queue_free()
		
	

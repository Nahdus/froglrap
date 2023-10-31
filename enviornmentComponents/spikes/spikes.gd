extends Node2D


var scale_ratio = 0.05

var _world
var _scale_factor
var _floor
var _world_size
var _floor_height
var _tile_size

var spike_facing_right
var spike_facing_left
var player

func _loadvars():
	_world = get_parent()
	_scale_factor = _world.get_scale_factor()
	_world_size = _world.get_world_size()
	_floor_height = _world.get_floor_height()
	_tile_size = _world.get_tile_size()
	
func _load_resources():
	spike_facing_right = load("res://enviornmentComponents/spikes/spike_right.tscn").instance()
	spike_facing_left = load("res://enviornmentComponents/spikes/spike_left.tscn").instance()
	player = get_parent().get_node("frog")
		
func _place_spikes():
#	var spike_facing_right_pos = Vector2(_tile_size.x*_scale_factor.x/2,_world_size.y*_scale_factor.y - _floor_height*_tile_size.y*_scale_factor.y )
#	var spike_facing_left_pos = Vector2(_world_size.x*_scale_factor.x - (_tile_size.x*_scale_factor.x)/2,_world_size.y*_scale_factor.y - _floor_height*_tile_size.y*_scale_factor.y)
	var spike_facing_right_pos = Vector2(_tile_size.x*_scale_factor.x/4,_world_size.y*_scale_factor.y - _floor_height*_tile_size.y*_scale_factor.y - 32 )
	var spike_facing_left_pos = Vector2(_world_size.x*_scale_factor.x - (_tile_size.x*_scale_factor.x)/4,_world_size.y*_scale_factor.y - _floor_height*_tile_size.y*_scale_factor.y - 32)
	spike_facing_right.set_position(spike_facing_right_pos)
#	spike_facing_right.set_scale(_scale_factor)
	spike_facing_left.set_position(spike_facing_left_pos)
#	spike_facing_left.set_scale(_scale_factor)
	spike_facing_right.set_target(player)
	add_child(spike_facing_right)
	spike_facing_left.set_target(player)
	add_child(spike_facing_left)
	
	
func _ready():
	_loadvars()
	_load_resources()
	_place_spikes()
	

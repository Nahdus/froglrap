extends Node2D


#0.05 scale of area is one pixel
var scale_ratio = 0.05

var _world
var _scale_factor
var _floor
var _world_size
var _floor_height
var _tile_size

var _water_scale
var _wate_position

func _loadvars():
	_world = get_parent()
	_scale_factor = _world.get_scale_factor()
	_world_size = _world.get_world_size()
	_floor_height = _world.get_floor_height()
	_tile_size = _world.get_tile_size()
	
func _scale_and_position():
	_water_scale = Vector2(_world_size.x*scale_ratio,(_floor_height-1)*_tile_size.y*scale_ratio)
	_wate_position = Vector2((_world_size.x*_scale_factor.x)/2,(_world_size.y - (_floor_height*_tile_size.y)/2)+8)
	$waterArea.set_scale(_water_scale)
	self.set_position(_wate_position)


func _ready():
	_loadvars()
	_scale_and_position()


extends StaticBody2D


var _center
var _tile_index
var _tile_type = "platform"

signal landed_on_platform

func _ready():
	_center = $Area2D/Position2D
	pass # Replace with function body.

func set_tile_index(i):
	_tile_index = i

func get_tile_index():
	return _tile_index

func _on_Area2D_body_entered(body):
	emit_signal("landed_on_platform",_center.get_global_position(),_tile_type,_tile_index)
	pass # Replace with function body.

func subscribe(target,method):
	connect("landed_on_platform",target,method)

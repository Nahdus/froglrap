extends StaticBody2D


var _center
var _tile_index
signal landed_on_platform

var _tile_type = "tempTile"

var _tile_active_flag:bool = true
var _tile_disappear_time = 0.5
var _tile_reappear_time = 3.0
var _tile_disappear_timer
var _tile_reappear_timer

func _ready():
	_center = $Area2D/Position2D
	$tileSprite2.set_visible(false)
	pass # Replace with function body.


func set_tile_index(i):
	_tile_index = i

func get_tile_index():
	return _tile_index
	
func appeartile():
	_tile_reappear_timer.queue_free()
	$CollisionShape2D.set_disabled(false)
	$tileSprite2.set_visible(false)
	$tileSprite.set_visible(true)


func remove_tile():
	_tile_disappear_timer.queue_free()
	$CollisionShape2D.set_disabled(true)
	$tileSprite.set_visible(false)
	$tileSprite2.set_visible(true)
	_tile_reappear_timer = Timer.new()
	_tile_reappear_timer.connect("timeout",self,"appeartile")
	_tile_reappear_timer.set_one_shot(true)
	_tile_reappear_timer.set_wait_time(_tile_reappear_time)
	add_child(_tile_reappear_timer)
	_tile_reappear_timer.start()
	


func fade_tile():
	
	_tile_active_flag = false
	_tile_disappear_timer = Timer.new()
	_tile_disappear_timer.connect("timeout",self,"remove_tile")
	_tile_disappear_timer.set_one_shot(true)
	_tile_disappear_timer.set_wait_time(_tile_disappear_time)
	add_child(_tile_disappear_timer)
	_tile_disappear_timer.start()
		


func _on_Area2D_body_entered(body):
	emit_signal("landed_on_platform",_center.get_global_position(),_tile_type,_tile_index)
	fade_tile()
	
	
	

func subscribe(target,method):
	connect("landed_on_platform",target,method)

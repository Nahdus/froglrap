extends Node2D


var _scale_factor:Vector2
var _world_size:Vector2

var _x_offset:float
var _y_offset:float

var _floor_height:float = 8

var _tile_size = Vector2(32,32)

var score = 0
var high_score = 0

var score_node
var high_score_node
var reason_node
var game_over_node

func _ready():
	
	score_node = $score
	high_score_node = $highScore
	high_score = HighScore.get_high_score()
	score_node.set_text("Score: "+str(score))
	high_score_node.set_text("High Score: "+str(high_score))
	reason_node = $reason
	game_over_node = $gameOver
	pass # Replace with function body.

func set_scale_factor(scale_factor:Vector2):
	_scale_factor = scale_factor
	
func get_tile_size():
	return _tile_size
	
func set_tile_size(tile_size):
	_tile_size = tile_size


func get_scale_factor()->Vector2:
	return _scale_factor

	
func get_world_size():
	return _world_size
	
func set_world_size(world_size:Vector2):
	_world_size = world_size
	
func set_x_offset(x_offset:float):
	_x_offset = x_offset
	
func get_x_offset():
	return _x_offset
	
func set_y_offset(y_offset:float):
	_y_offset = y_offset
	
func get_y_offset():
	return _y_offset
	
func set_floor_height(height):
	_floor_height = _floor_height
	
func get_floor_height():
	return _floor_height

func subscribe_platform_landing(target,method):
	$frog.subscribe_platform_landing(target,method)

func subscribe_temp_tile_landing(target,method):
	$frog.subscribe_temp_tile_landing(target,method)
	
	
func add_score():
	$scoreeat.play()
	score+=1
	score_node.set_text("Score: "+str(score))
	if score>high_score:
		HighScore.set_high_score(score)
		high_score = score
		high_score_node.set_text("High Score: "+str(high_score))
	if score >30:
		game_over("you will die of oldage and or starvation")

func game_over(reason):
	$gameovermenue.set_visible(true)
	reason_node.set_text(reason)
	game_over_node.set_visible(true)
	reason_node.set_visible(true)

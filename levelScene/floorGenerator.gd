extends Node2D

var world:Node2D

var projectResolution=OS.get_window_size()

var floor_config = [1,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1]

var temp_tile
var platform_tile

var tile_size 

var x_offset

var number_of_tiles = len(floor_config)

var buffer_tiles = 1

var width_tiles
var height_tiles

var width_scaling_factor
var height_scaling_factor
var scale_factor

var y_offset

var floor_height = 8




func _load_resources():
	temp_tile = load("res://enviornmentComponents/floorTiles/tempTile.tscn")
	platform_tile = load("res://enviornmentComponents/floorTiles/platform.tscn")

func platform_landing_detector(type,index):
	pass
	
	
func temp_tile_landing_detector(type,index):
	pass
	
	

func subscribe_to_signals():
	world.subscribe_platform_landing(self,"platform_landing_detector")
	world.subscribe_temp_tile_landing(self,"temp_tile_landing_detector")
	pass

func _ready():
	_load_resources()
	_sync_world()
	subscribe_to_signals()
	_lay_tiles()



func _sync_world():
	world = get_parent()
	tile_size = world.get_tile_size()
	x_offset = world.get_tile_size().x
	width_tiles = tile_size.x * (number_of_tiles + buffer_tiles)
	height_tiles = tile_size.y * (number_of_tiles + buffer_tiles)
	width_scaling_factor = projectResolution.x/width_tiles
	height_scaling_factor = projectResolution.y/height_tiles
	scale_factor = Vector2(width_scaling_factor,height_scaling_factor)
#	print_debug("scale factor",scale_factor)
	self.set_scale(scale_factor)
	y_offset = height_tiles - tile_size.y*floor_height
	world.set_scale_factor(scale_factor)
	world.set_world_size(projectResolution)
	world.set_y_offset(y_offset)
	world.set_floor_height(floor_height)
#	print(world._scale_factor)





func _lay_tiles():
	var i = 0
	var tile
	var platform_index = 0
	var temp_tile_index = 0
	for tile_flag in floor_config:
		if tile_flag == 0:
			tile = temp_tile.instance()
			tile.position.x += x_offset + 32*i
			tile.position.y += y_offset
			tile.set_tile_index(temp_tile_index)
			temp_tile_index +=1
			self.add_child(tile)
		if tile_flag == 1:
			tile = platform_tile.instance()
			tile.position.x += x_offset + 32*i
			tile.position.y += y_offset
			tile.set_tile_index(platform_index)
			platform_index +=1
			self.add_child(tile)
		i+=1







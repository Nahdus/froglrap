extends Node2D

var world
var world_size
var floor_height
var x_offset = 96
var y_offset = 96
var x_pos_offset = 16
var tile_size
var scale_factor

var crocks_pos = [1,1,1,1,1,1,1]
var crock_scene

var number_of_fly = 30
var shine_bug_scene

var floor_config = [1,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1]
var platform_target = []


var _player

var _timer

func _sync_with_world():
	world = get_parent()
	world_size = world.get_world_size()
	floor_height = world.get_floor_height()
	tile_size = world.get_tile_size()
	scale_factor = world.get_scale_factor()
	tile_size = tile_size*scale_factor
	_player = get_parent().get_node("frog")

func _load_resources():
	crock_scene = load('res://NPCs/crock.tscn')
	shine_bug_scene = load('res://NPCs/shinebug.tscn')
	
func crock_attack(crock_options):
	_timer.queue_free()
	if len(crock_options)>1:
		randomize()
		var percent = randf()
		if percent > 0.5:
			crock_options[0].alert()
		else:
			crock_options[1].alert()
	else:
		crock_options[0].alert()
		
func crock_npc_react(tile_index):
	var crock_options =platform_target[tile_index]
	_timer = Timer.new()
	_timer.set_wait_time(0.5)
	_timer.connect("timeout",self,"crock_attack",[crock_options])
	_timer.one_shot = true
	add_child(_timer)
	_timer.start()
	pass


func platform_sensor(tile_type,tile_index):
	crock_npc_react(tile_index)
	

func _subscribe_to_signal():
	world.subscribe_platform_landing(self,"platform_sensor")

func _ready():
	_sync_with_world()
	_load_resources()
	_subscribe_to_signal()
	_add_crocks()
	_add_flies()
	
	
func _add_crocks():
	var i =0
	var label =0
	var pos_x_right = 0
	var pos_x_left = 0
	for each in floor_config:
		i+=1
		
		if each == 1:
			pos_x_right = i*tile_size.x*scale_factor.x - x_offset
			pos_x_left = i*tile_size.x*scale_factor.x + x_offset
			var y = world_size.y*scale_factor.y - tile_size.y*floor_height + y_offset*scale_factor.y
			var crock_right = crock_scene.instance()
			var crock_left = crock_scene.instance()
			crock_left.set_scale(scale_factor)
			crock_left.get_node("debug_label").set_text("left "+str(label))
			crock_right.set_scale(scale_factor)
			crock_right.set_player(_player)
			crock_right.get_node("debug_label").set_text("right "+str(label))
			crock_right.direction("right")
			crock_left.direction("left")
			crock_left.set_player(_player)
#			crock_left.position = Vector2(pos_x_left,y)
			crock_left.set_crock_position(Vector2(pos_x_left,y))
			crock_right.get_node("Sprite").set_flip_h(true)
			crock_right.set_crock_position(Vector2(pos_x_right,y))
			var target = []
			if label != 0:
#				crock_right.set_visible(false)
				self.add_child(crock_right)
				crock_right.set_crock_height(y_offset*scale_factor.y)
				crock_right.set_crock_distance(x_offset*scale_factor.x*2)
				crock_right.set_crock_time(0.5)
				target.append(crock_right)
#				crock_right._compute_physics_vars()
			if label != 6:
#				crock_left.set_visible(false)
				self.add_child(crock_left)
				crock_left.set_crock_height(y_offset*scale_factor.y)
				crock_left.set_crock_distance(x_offset*scale_factor.x*2)
				crock_left.set_crock_time(0.5)
				target.append(crock_left)
#				crock_right._compute_physics_vars()
				
			platform_target.append(target)
			label +=1
	
func _add_flies():
	while number_of_fly>0:
		var shine_bug = shine_bug_scene.instance()
		randomize()
		var random_no=randf()
		shine_bug.position.x = world_size.x*random_no
		if random_no<0.5:
			shine_bug.get_node("Sprite").set_flip_h(true)
		shine_bug.subscribe_to_score_signal(world,"add_score")
		self.add_child(shine_bug)
		number_of_fly-=1


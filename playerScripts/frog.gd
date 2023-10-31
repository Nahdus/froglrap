extends KinematicBody2D

var world
var scale_factor
var floor_detector:RayCast2D


export var low_jump_height:float =32.0
export var high_jump_height:float = 96.0

export var low_jump_distance:float = 32.0 
export var high_jump_distance:float = 128.0

var time = 0.5
var low_jump_gravity:float #= -(2*low_jump_height)/pow((time/2),2)
var low_jump_vertical_speed:float #= low_jump_gravity*(time/2)

var low_jump_horizontal_speed:float #= -(low_jump_vertical_speed*low_jump_distance)/(4*low_jump_height)

var high_jump_gravity:float #= -(2*high_jump_height)/pow((time/2),2)
var high_jump_vertical_speed:float #= high_jump_height*(time/2)

var high_jump_horizontal_speed:float #= -(high_jump_vertical_speed*high_jump_distance)/(4*high_jump_height)


var death_height = 32
var death_fall_time = 4

var death_horizontal_speed = 0.0
var death_vertical_speed
var death_gravity


signal landed_on_platform
signal landed_on_temp_tile



func adjust_frog_positon():
	world = get_parent()
	scale_factor = world.get_scale_factor()
	low_jump_height = low_jump_height * scale_factor.y
	low_jump_distance = low_jump_distance * scale_factor.x
	
	high_jump_height = high_jump_height * scale_factor.y
	high_jump_distance = high_jump_distance * scale_factor.x
	low_jump_gravity = -(2*low_jump_height)/pow((time/2),2)
	low_jump_vertical_speed = low_jump_gravity*(time/2)
	low_jump_horizontal_speed = -(low_jump_vertical_speed*low_jump_distance)/(4*low_jump_height)
#	print_debug(low_jump_horizontal_speed)
	
	high_jump_gravity = -(2*high_jump_height)/pow((time/2),2)
	high_jump_vertical_speed = high_jump_gravity*(time/2)
	high_jump_horizontal_speed = -(high_jump_vertical_speed*high_jump_distance)/(4*high_jump_height)

	death_gravity =  -(2*death_height)/pow((death_fall_time/2),2)
	death_vertical_speed = -death_gravity*(death_fall_time/2)
	
	self.set_scale(world.get_scale_factor())
	var world_size = world.get_world_size()
	var y_offset =  world.get_y_offset()
	self.position = Vector2(world_size.x/2,y_offset*scale.y-20)

func debug_position(pos):
	var sprite = Sprite.new()
	var image_texture = ImageTexture.new()
	var image_object = Image.new()
	image_object.load("res://assets/frog.png")
	image_texture.create_from_image(image_object)
	sprite.set_texture(image_texture)
	sprite.position=pos
	get_parent().add_child(sprite)



func nearest_platform(pos,platform_type,tile_index):
#	print_debug("landed on a platform")
#	print_debug("x-coordinate",pos.x,tile_index)
	if platform_type == "platform":
		emit_signal("landed_on_platform",platform_type,tile_index)
	if platform_type == "tempTile":
		emit_signal("landed_on_temp_tile",platform_type,tile_index)
	self.set_global_position(Vector2(round(pos.x),self.get_global_position().y))
#	print(pos)

func subscribe_platform_landing(target,method):
	self.connect('landed_on_platform',target,method)

func subscribe_temp_tile_landing(target,method):
	self.connect("landed_on_temp_tile",target,method)


func _ready():
	floor_detector = $"floorDetector"
	var floors = get_parent().get_node("floor").get_children()
	for each in floors:
		each.subscribe(self,"nearest_platform")
	adjust_frog_positon()
	
func floor_detected():
	return floor_detector.is_colliding()

func count_time(sec:float,refrence,functionName):
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = sec
	timer.one_shot = true
	timer.connect("timeout", refrence, functionName)
	timer.start()


func _on_waterArea_body_entered(cause):
	$stateMachineController.die("You Drowned")
	$drowning.play()
	world.game_over("You Drowned to death")
	pass # Replace with function body.

func killed_by_aligator():
	$aligatorbite.play()
	$stateMachineController.die("Killed by Aligator")
	world.game_over("Killed by Frog hunter")
	
func killed_by_spike():
	$spikedeath.play()
	$stateMachineController.die("Killed by Spike")
	world.game_over("Killed by Spike")
	

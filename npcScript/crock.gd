extends KinematicBody2D


var _crock_position

var crock_height:float
var crock_distance:float  
var crock_time:float
var _dir

var crock_jump_active = false

var _crock_horizontal_speed
var _crock_vertical_speed
var _crock_gravity

var _player

signal player_touched

func _compute_physics_vars():
	_crock_gravity = -(2*crock_height)/pow((crock_time/2),2)
	_crock_vertical_speed = _crock_gravity*(crock_time/2)
	_crock_horizontal_speed = (_crock_vertical_speed*crock_distance)/(4*crock_height)



func set_player(player):
	_player = player

func direction(dir):
	_dir = dir
	if dir == "right":
		self.get_node("Sprite").set_flip_h(true)


func set_crock_height(height):
	crock_height = height

func set_crock_distance(distance):
	crock_distance = distance
	
func set_crock_time(time):
	crock_time = time

func set_crock_position(position):
	_crock_position = position
	self.set_position(position)

func alert():
	if !crock_jump_active:
		if _dir=="right":
			var animation_right_node = self.get_node("animation_right")
			animation_right_node.play_animation()
			
		if _dir=="left":
			var animation_left_node = self.get_node("animation_left")
			animation_left_node.play_animation()
		
#		self.get_node("animation_left").set_visible(true)
		

	
func jump():
	$attacksfx.play()
	_compute_physics_vars()
	$Sprite.set_visible(true)
	crock_jump_active = true
	pass

func reset_crock():
	crock_jump_active = false
	self.set_position(_crock_position)
	$Sprite.set_visible(false)
	
func _physics_process(delta):
	if crock_jump_active:
		_crock_vertical_speed = _crock_vertical_speed - _crock_gravity*delta
		if _dir == "right":
			self.move_and_slide(Vector2(-1*_crock_horizontal_speed,_crock_vertical_speed),Vector2.UP)
		if _dir == "left":
			self.move_and_slide(Vector2(1*_crock_horizontal_speed,_crock_vertical_speed),Vector2.UP)
		if 	self.position.y>1000:
			reset_crock()
			
		


func _load_vars():
	pass
	
func _setup_nodes():
	self.get_node("animation_right").set_visible(false)
	self.get_node("animation_left").set_visible(false)
	$Sprite.set_visible(false)
#	_compute_physics_vars()

func _ready():
	_load_vars()
	_setup_nodes()
	connect("player_touched",_player,"killed_by_aligator")
	
	
	




func _on_AnimationPlayer_animation_finished(anim_name):
	if _dir=="right":
		var animation_right_node = self.get_node("animation_right")
		animation_right_node.stop_animation()
		jump()
	if _dir=="left":
		var animation_left_node = self.get_node("animation_left")
		animation_left_node.stop_animation()
		jump()
	


func _on_Area2D_body_entered(body):
	emit_signal("player_touched")
	

extends Node2D

var crock
var animation_player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func connect_animationSignal():
	animation_player.connect("animation_finished",crock,"_on_AnimationPlayer_animation_finished")

func _load_vars():
	crock = get_parent()
	animation_player = get_node("AnimationPlayer")

func _ready():
	_load_vars()
	connect_animationSignal()
	

func play_animation():
	self.set_visible(true)
	animation_player.play("peak")

func stop_animation():
	self.set_visible(false)
	animation_player.stop(true)

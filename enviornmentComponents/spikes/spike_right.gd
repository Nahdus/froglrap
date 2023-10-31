extends StaticBody2D

var _target
signal hit_by_spike

func _ready():
	pass

func set_target(target):
	_target = target
	connect("hit_by_spike",_target,"killed_by_spike")

func _on_hitBox_body_entered(body):
	if body.name == "frog":
		emit_signal("hit_by_spike")
			

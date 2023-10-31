extends StaticBody2D


var _target
signal hit_by_spike
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_target(target):
	_target = target
	connect("hit_by_spike",_target,"killed_by_spike")

func _on_hitBox_body_entered(body):
	if body.name == "frog":
		print_debug(body.name)
		emit_signal("hit_by_spike")
	

extends KinematicBody2D

var MaxSpeed = 500
var MinSpeed = 30



signal add_score

func _ready():
	pass
	
	
func subscribe_to_score_signal(target,function):
	connect("add_score",target,function)


func _on_hurtBox_body_entered(body):
	self.queue_free()
	emit_signal("add_score")

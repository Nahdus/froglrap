extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
export var gamescene:PackedScene
export var optionscene:PackedScene
export var controlsscene:PackedScene

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_button_up():
	$trout.play()
	$animate.play("start")
	get_tree().change_scene("res://levelScene/World.tscn")
	pass # Replace with function body.


func _on_options_button_up():
	$trout.play()
	$animate.play("options")
	pass # Replace with function body.


func _on_controls_button_up():
	$trout.play()
	$animate.play("controls")
	pass # Replace with function body.


func _on_tutorial_button_up():
	pass # Replace with function body.


func _on_animate_animation_finished(anim_name):
	if anim_name == "start":
		pass
	pass # Replace with function body.

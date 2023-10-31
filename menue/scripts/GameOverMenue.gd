extends Control



func _ready():
	set_process_input(false)



func _on_restart_button_up():
	print_debug("button click on restart")
	get_tree().change_scene("res://levelScene/World.tscn")
	


func _on_mainMenue_button_up():
	print_debug("button click on main menue")
	get_tree().change_scene("res://menue/menue.tscn")


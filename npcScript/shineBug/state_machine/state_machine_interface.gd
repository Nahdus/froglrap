extends StateMachine


#var _transistion_table ={}
#var _state_nodes = {}
#var _current_state
#var _state_machine

func _ready():
	pass
	
func add_state_to_table(state_object,transistion_list:Array,current = false):
	_transistion_table[state_object.get_name()] = transistion_list
	
	_state_nodes[state_object.get_name()] = state_object
	
	if current:
		set_current_state(state_object)
		_state_nodes[_current_state.get_name()].enter(null)
		
func set_transistion_table(state_map:Dictionary):
	_transistion_table = state_map
	
func set_current_state(current_state):
	_current_state = current_state
	
func transistion_to_state(state_name,arg=null):
	for each in _transistion_table[_current_state.get_name()]:
		if state_name == each.get_name():
			set_current_state(_state_nodes[state_name])
			_state_nodes[state_name].enter(arg)
			return
		
		
func physics_process(delta):
#	print_debug("processing")
	_state_nodes[_current_state.get_name()].update(delta)

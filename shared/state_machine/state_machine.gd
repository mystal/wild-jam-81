class_name StateMachine extends Node

var current_state: State = null
var states: Dictionary = {}
var player: Player = null

#{"idle": Idle}
func register_player(input_player: Player) -> void:
	player = input_player
	
func _ready() -> void:
	await owner.ready
	
	for child in get_children():
		if child is State:
			#assign states to child nodes of state machine
			states[child.name.to_lower()] = child
			#update reference to the state machine in each constituent state
			child.state_machine = self
			child.player = player
	
	#default to idle state
	if states.has("idle"):
		change_state("idle")
		
func change_state(new_state_name: String) -> void:
	#first check we have a state already, and exit accordingly
	if current_state:
		current_state.exit()
	
	if states.has(new_state_name):
		current_state = states[new_state_name]
		current_state.enter()
	else:
		printerr("State: ", new_state_name, " not found!")
		
func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func handle_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
	

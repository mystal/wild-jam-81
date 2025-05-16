class_name StateMachine extends Node

@export var initial_state: String

var current_state: State = null
var states: Dictionary = {}
var player: Player = null
var character: Character = null

#{"idle": Idle}
func register_player(in_player: Player) -> void:
	player = in_player

func register_character(in_character: Character) -> void:
	character = in_character


func _ready() -> void:
	await owner.ready

	for child in get_children():
		if child is State:
			#assign states to child nodes of state machine
			states[child.name.to_lower()] = child
			#update reference to the state machine in each constituent state
			child.state_machine = self
			child.player = player
			child.character = character

	if initial_state and states.has(initial_state):
		change_state(initial_state)
	elif states.has("idle"):
		# Default to idle state if no other initial state provided
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

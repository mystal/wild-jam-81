class_name CharacterIdle extends State

@export var anim_name: String = "idle"
@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var next_state: State

var _timer: float = 0.0

func enter() -> void:
	character.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	character.animated_sprite_2d.play(anim_name + "_" + character.get_last_direction())

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	_timer -= _delta
	if _timer <= 0:
		state_machine.change_state(next_state.name.to_lower())
		

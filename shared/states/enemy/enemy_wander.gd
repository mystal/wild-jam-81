class_name EnemyWander extends State

@export var anim_name: String = "wander"
@export var wander_speed: float = 20.0
@export_category("AI")
@export var state_animation_duration: float = 0.5
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: State

const DIRECTIONS = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var _direction: Vector2
var _timer: float = 0.0

func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	_direction = DIRECTIONS.pick_random()
	enemy.velocity = _direction * wander_speed
	enemy.last_direction = _direction
	enemy.animated_sprite_2d.play(anim_name + "_" + enemy.get_last_direction())

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	_timer -= _delta
	if _timer <= 0:
		state_machine.change_state(next_state.name.to_lower())
		

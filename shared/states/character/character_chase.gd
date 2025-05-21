class_name CharacterChase extends State

@export var anim_name: String = "wander"
@export var chase_speed: float = 40.0
@export var turn_rate: float = 0.25

@export_category("AI")
@export var detection_area: DetectionArea
@export var attack_area: HitBox
@export var state_aggro_duration: float = 0.5
@export var next_state: State

var _jump_cooldown := 0.0

const DIRECTIONS = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var _direction: Vector2
var _timer: float = 0.0
var _can_see_player: bool = false

func _ready() -> void:
	if detection_area:
		detection_area.player_entered.connect(_on_player_enter)
		detection_area.player_exited.connect(_on_player_exit)

func _on_player_enter() -> void:
	_can_see_player = true
	#if state_machine.current_state is CharacterStateStun:
		#return
	state_machine.change_state(self.name.to_lower())

func _on_player_exit() -> void:
	_can_see_player = false


func enter() -> void:
	_timer = state_aggro_duration
	character.animated_sprite_2d.play(anim_name + "_" + character.get_last_direction())
	if attack_area:
		attack_area.monitoring = true
	

func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
	_can_see_player = false

func physics_update(_delta: float) -> void:
	_jump_cooldown -= _delta
	var new_direction: Vector2 = character.global_position.direction_to(PlayerManager.player.global_position)
	_direction = lerp(_direction, new_direction, turn_rate)
	character.velocity = _direction * chase_speed
	character.last_direction = _direction
	if character.last_direction == _direction:
		character.animated_sprite_2d.play(anim_name + "_" + character.get_last_direction())
	
	if _jump_cooldown <= 0:
		_jump_cooldown = randf_range(1.0, 2.5)
		state_machine.change_state("jump")
		return
	
	if !_can_see_player:
		_timer -= _delta
		if _timer <= 0:
			state_machine.change_state(next_state.name.to_lower())
	else:
		_timer = state_aggro_duration

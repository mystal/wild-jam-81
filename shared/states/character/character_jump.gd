class_name CharacterJump extends State

@export var anim_name: String = "jump"
@export var jump_speed: float = 200.0
@export var jump_duration: float = 0.5
@export var next_state: State

var _timer := 0.0
var _jump_direction := Vector2.ZERO

func enter() -> void:
    _timer = jump_duration
    character.animated_sprite_2d.play(anim_name)
    _jump_direction = (PlayerManager.player.global_position - character.global_position).normalized()

func physics_update(delta: float) -> void:
    if _timer > 0:
        character.velocity = _jump_direction * jump_speed
        _timer -= delta
    else:
        character.velocity = Vector2.ZERO
        state_machine.change_state(next_state.name.to_lower())

func exit() -> void:
    character.velocity = Vector2.ZERO
class_name CharacterHit extends State
@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"

@export var anim_name: String = "hit"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
@export var next_state: State

const DIRECTIONS = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var _direction: Vector2
var _animation_finished: bool

func enter() -> void:
	_animation_finished = false
	#_direction = DIRECTIONS.pick_random()
	character.last_direction = _direction
	character.velocity = _direction * knockback_speed
	flash()
	shake()

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	if _animation_finished == true:
		state_machine.change_state(next_state.name)
	character.velocity -= character.velocity * decelerate_speed * _delta
		
func flash(time = 0.2):
	sprite.modulate = Color(5,5,5)
	await get_tree().create_timer(time).timeout
	sprite.modulate = Color.WHITE


func shake(intensity := 2.0,time := 0.1):
	var tween = create_tween()
	tween.tween_property(sprite,"position",Vector2(-1,-1)*intensity,time/3)
	tween.tween_property(sprite,"position",Vector2.LEFT*intensity,time/3)
	tween.tween_property(sprite,"position",Vector2.ZERO,time/3)
	_animation_finished

		

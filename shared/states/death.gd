class_name Death extends State

@export var anim_name: String = "death"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

const DIRECTIONS = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var _damage_position: Vector2
var _direction: Vector2

func enter() -> void:
	character.death_animation.animation_finished.connect(_on_death_animation_finished)
	character.invulnerable = true
	_damage_position = character.hurt_box.global_position
	_direction = character.global_position.direction_to(_damage_position)
	character.last_direction = _direction
	character.velocity = _direction * knockback_speed
	character.death_animation.visible = true
	character.death_animation.play("death")

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	character.velocity -= character.velocity * decelerate_speed * _delta

func _on_death_animation_finished() -> void:
	character.queue_free()

		

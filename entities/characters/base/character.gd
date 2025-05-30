class_name Character extends CharacterBody2D

@export var state_machine: StateMachine
@export var speed: float = 30.0
@export var animated_sprite_2d: AnimatedSprite2D
@export var faction: Enums.Faction
@export var death_animation: AnimatedSprite2D

signal direction_changed(new_direction: Vector2)


var invulnerable: bool = true

var last_direction = Vector2.DOWN:
	set(_v):
		last_direction = _v
		direction_changed.emit(last_direction)

var direction = Vector2.ZERO

func _ready() -> void:
	state_machine.register_character(self)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	move_and_slide()

func get_last_direction() -> String:
	direction_changed.emit(last_direction)
	if last_direction.y < 0:
		return "up"
	elif last_direction.x < 0:
		return "left"
	elif last_direction.x > 0:
		return "right"
	else:
		return "down"

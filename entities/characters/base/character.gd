class_name Character extends CharacterBody2D

@export var state_machine: StateMachine
@export var speed: float = 30.0
@export var animated_sprite_2d: AnimatedSprite2D
@export var faction: Enums.Faction

signal direction_changed(new_direction: Vector2)

var last_direction = Vector2.DOWN
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

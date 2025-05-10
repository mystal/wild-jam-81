class_name Player extends CharacterBody2D

signal direction_changed(new_direction: Vector2)

@export var speed := 300.0
@export var max_health := 100.0
@export_range(1, 20, 0.5) var decelerate_speed := 5.0

var last_direction = Vector2.DOWN
var direction = Vector2.ZERO
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
var can_attack: bool = true
var is_attacking: bool = false
var current_health: float = max_health

func _ready() -> void:
	PlayerManager.register(self)
	state_machine.register_player(self)

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	state_machine.physics_update(delta)
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.handle_input(event)

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

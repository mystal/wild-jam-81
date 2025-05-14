class_name Player extends CharacterBody2D

signal direction_changed(new_direction: Vector2)

@export var speed := 300.0
@export_range(1, 20, 0.5) var decelerate_speed := 5.0
@export var faction: Enums.Faction

var last_direction = Vector2.DOWN
var direction = Vector2.ZERO
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
var can_attack: bool = true
var is_attacking: bool = false
@onready var projectile_weapon: ProjectileWeapon = $ProjectileWeapon

@onready var interaction_area: Area2D = $InteractionArea2D
@onready var _interaction_collision: CollisionShape2D = $InteractionArea2D/InteractionCollision
@onready var _interaction_offset := absf(_interaction_collision.position.y)
@onready var spell_manager: SpellManager = $SpellManager

var current_health: float:
	get():
		return $Health.current

func _ready() -> void:
	PlayerManager.register(self)
	state_machine.register_player(self)
	

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	# Update interaction collider to match new direction, if any.
	match direction:
		Vector2.UP:
			_interaction_collision.position = Vector2.UP * _interaction_offset
		Vector2.DOWN:
			_interaction_collision.position = Vector2.DOWN * _interaction_offset
		Vector2.LEFT:
			_interaction_collision.position = Vector2.LEFT * _interaction_offset
		Vector2.RIGHT:
			_interaction_collision.position = Vector2.RIGHT * _interaction_offset

	state_machine.physics_update(delta)
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()

	projectile_weapon.global_position = global_position + (dir * 13.0)

	projectile_weapon.look_at(mouse_pos)

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

func _on_hurt_box_damaged(damage:float) -> void:
	$Health.take_damage(damage)
		
func update_hp(amount: int) -> void:
	$Health.heal(amount)
	#update HUD here
		
func cast_spell(item_effect: ItemEffect) -> void:
	spell_manager.cast_spell(item_effect)

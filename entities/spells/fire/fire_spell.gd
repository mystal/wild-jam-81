class_name FireSpell extends Node2D

enum State {INACTIVE, TRAVEL, HIT}
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: HitBox = $HitBox

var current_state
var player: Player
var direction: Vector2
var speed: int = 0
var decelerate_speed: int = 1

func _ready() -> void:
	visible = false
	current_state = State.INACTIVE
	player = PlayerManager.player

func _physics_process(delta: float) -> void:
	if current_state == State.TRAVEL:
		global_position += direction * speed * delta
		#global_position = global_position + (direction * 13.0)

func cast(item_effect: FireSpellEffect, travel_direction: Vector2) -> void:
	hit_box.damage = item_effect.damage
	var mouse_pos = get_global_mouse_position()
	direction = (mouse_pos - global_position).normalized()
	#direction = travel_direction
	speed = item_effect.projectile_speed
	decelerate_speed = item_effect.decelerate_speed
	current_state = State.TRAVEL
	animated_sprite_2d.play("fire_spell_travel")
	visible = true
	rotation = Vector2.RIGHT.angle_to(direction)
	pass


func _on_hit_box_hit(hurt_box: HurtBox) -> void:
	if hurt_box.get_parent() is not Player:
		current_state = State.HIT
		global_position = hurt_box.global_position
		animated_sprite_2d.play("flame_explosion")

func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == State.HIT:
		queue_free()

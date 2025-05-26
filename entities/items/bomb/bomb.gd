@tool
class_name Bomb extends Node2D
enum BombState {
		INACTIVE,
		COUNTDOWN,
		FLASH,
		EXPLODE,
		DONE
	}
var current_state: BombState = BombState.INACTIVE
@export var faction: Enums.Faction
@onready var countdown_timer: Timer = $CountdownTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var flash_timer: Timer = $FlashTimer
@onready var explosion_sprite: AnimatedSprite2D = $ExplosionSprite
@onready var hit_box: HitBox = $HitBox
@onready var hit_box_shape: CircleShape2D = $HitBox/Shape.shape as CircleShape2D

var _bomb_effect: BombEffect
var _flash_cycle_time: float = 0.15

func _ready() -> void:
	countdown_timer.timeout.connect(_on_countdown_timeout)
	flash_timer.timeout.connect(_on_flash_timeout)
	hit_box.monitoring = false

func _on_countdown_timeout() -> void:
	current_state = BombState.FLASH
	flash_timer.wait_time = _flash_cycle_time
	flash_timer.start()
	await get_tree().create_timer(_bomb_effect.flash_timer).timeout
	explode()

func _on_flash_timeout() -> void:
	flash()

func explode() -> void:
	explosion_sprite.visible = true
	current_state = BombState.EXPLODE
	flash_timer.stop()
	sprite_2d.modulate = Color.WHITE
	hit_box.damage = _bomb_effect.damage
	hit_box_shape.radius = _bomb_effect.area_of_effect
	hit_box.monitoring = true
	explosion_sprite.animation_finished.connect(_on_explosion_animation_finished)
	explosion_sprite.play("explode")
	sprite_2d.visible = false

func _on_explosion_animation_finished() -> void:
	queue_free()

func place(bomb_effect: BombEffect) -> void:
	explosion_sprite.visible = false
	_bomb_effect = bomb_effect
	current_state = BombState.COUNTDOWN
	countdown_timer.wait_time = bomb_effect.explosion_timer - bomb_effect.flash_timer
	countdown_timer.start()
	sprite_2d.modulate = Color.WHITE

func flash():
	if sprite_2d.modulate == Color.WHITE:
		sprite_2d.modulate = Color(5,5,5)
	else:
		sprite_2d.modulate = Color.WHITE

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
@onready var collision_shape_2d: CollisionShape2D = $DestructionArea/CollisionShape2D
@onready var hit_box: HitBox = $HitBox
@onready var destruction_area: CollisionShape2D = $DestructionArea/CollisionShape2D

var _bomb_effect: BombEffect
var _flash_cycle_time: float = 0.15

func _ready() -> void:
    countdown_timer.timeout.connect(_on_countdown_timeout)
    flash_timer.timeout.connect(_on_flash_timeout)
    hit_box.collision.shape = CircleShape2D.new()

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
    hit_box.collision.shape = CircleShape2D.new()
    hit_box.collision.shape.radius = _bomb_effect.area_of_effect
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
    destruction_area.shape.radius = bomb_effect.area_of_effect

func flash():
    if sprite_2d.modulate == Color.WHITE:
        sprite_2d.modulate = Color(5,5,5)
    else:
        sprite_2d.modulate = Color.WHITE

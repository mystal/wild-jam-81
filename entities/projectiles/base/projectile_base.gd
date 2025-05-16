class_name ProjectileBase extends Node2D

@export var projectile_speed: int = 300
@export var lifetime: float = 5.0

var faction: Enums.Faction

func _ready() -> void:
	if lifetime > 0.0:
		await get_tree().create_timer(lifetime, false).timeout
		queue_free()

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * projectile_speed * delta

func _on_hit_box_hit(_hurt_box: HurtBox) -> void:
	queue_free()

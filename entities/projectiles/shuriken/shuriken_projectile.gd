class_name ShurikenProjectile extends Node2D

@export var projectile_speed: int = 300
var faction: Enums.Faction

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * projectile_speed * delta

func _on_hit_box_hit(_hurt_box: HurtBox) -> void:
	queue_free()

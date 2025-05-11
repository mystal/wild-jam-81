class_name ShurikenProjectile extends HitBox

@export var projectile_speed: int = 300

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * projectile_speed * delta

class_name ShurikenProjectile extends Area2D

@export var damage: int = 1
@export var projectile_speed: int = 300

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * projectile_speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is HitBox:
		area.take_damage(damage)

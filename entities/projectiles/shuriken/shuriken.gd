class_name Shuriken extends Area2D

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)

func _on_area_entered(area: Area2D) -> void:
	if area is HitBox:
		area.take_damage(damage)

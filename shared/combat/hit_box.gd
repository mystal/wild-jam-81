class_name HitBox extends Area2D

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var hurt_box := area as HurtBox
	if hurt_box:
		hurt_box.take_damage(damage)

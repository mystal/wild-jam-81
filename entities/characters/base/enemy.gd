class_name Enemy
extends Character

@onready var sprite: Enemy = $"."

func _ready() -> void:
	super._ready()
	faction = Enums.Faction.Enemy

func _on_hurt_box_damaged(damage: float) -> void:
	$Health.take_damage(damage)
	state_machine.change_state("hit")

func _on_health_died() -> void:
	queue_free()

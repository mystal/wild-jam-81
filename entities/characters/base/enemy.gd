class_name Enemy
extends Character

@onready var sprite: Enemy = $"."
@onready var hurt_box: HurtBox = $"HurtBox"

func _ready() -> void:
	super._ready()
	faction = Enums.Faction.Enemy
	invulnerable = false
	

func _on_hurt_box_damaged(hit_box: HitBox) -> void:
	if invulnerable == true:
		return
	$Health.take_damage(hit_box.damage)
	state_machine.change_state("hit")

func _on_health_died() -> void:
	state_machine.change_state("death")

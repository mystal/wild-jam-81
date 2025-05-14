class_name FireSpellEffect extends ItemEffect

@export var damage: int = 1
@export var projectile_speed: int = 100
@export var area_of_effect: int = 50
@export var decelerate_speed: int = 5

func use() -> void:
	PlayerManager.player.cast_spell(self)

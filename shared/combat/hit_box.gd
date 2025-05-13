class_name HitBox extends Area2D

signal hit(hurt_box: HurtBox)

@export var damage: float = 1

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _should_overlap(hurt_box: HurtBox) -> bool:
	if not hurt_box:
		return false
	var parent := get_parent()
	var other_parent := hurt_box.get_parent()
	if parent == other_parent:
		return false
	if "faction" in parent and "faction" in other_parent and parent.faction == other_parent.faction:
		return false
	return true

func _on_area_entered(area: Area2D) -> void:
	var hurt_box := area as HurtBox
	if _should_overlap(hurt_box):
		hurt_box.take_damage(damage)
		hit.emit(hurt_box)

class_name HurtBox extends Area2D

signal damaged(damage: float)

func take_damage(damage: float) -> void:
	print("[%s] take_damage: %.1f" % [get_parent().name, damage])
	damaged.emit(damage)

class_name HurtBox extends Area2D

signal damaged(hit_box: HitBox)

func take_damage(hit_box: HitBox) -> void:
	print("[%s] take_damage: %.1f" % [get_parent().name, hit_box.damage])
	damaged.emit(hit_box)

class_name HurtBox extends Area2D

@export var instigator: Node

signal damaged(damage: float)

func take_damage(damage: float) -> void:
	print("take_damage: " + str(damage))
	damaged.emit(damage)

class_name Destructable extends Area2D

signal destroyed()

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(_area: Area2D) -> void:
    destroyed.emit()

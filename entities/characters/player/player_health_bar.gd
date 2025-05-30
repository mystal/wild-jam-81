class_name PlayerHealthBar extends TextureProgressBar

@onready var health: Node = $'../Health'

func _ready() -> void:
	health.changed.connect(update)
	update(health.max_health, health.current)

func update(_old: float, _new: float):
	value = health.current * 100 / health.max_health

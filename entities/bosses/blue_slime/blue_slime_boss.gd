class_name BlueSlimeBoss extends Enemy
@onready var health: Health = $Health

func _ready() -> void:
    super._ready()
    health.died.connect(_on_health_died)

func _on_health_died() -> void:
    state_machine.change_state("death")

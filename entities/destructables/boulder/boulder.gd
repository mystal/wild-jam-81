class_name Boulder extends Area2D
@onready var destructable: Destructable = $Destructable

func _ready() -> void:
    destructable.destroyed.connect(_on_destroy)

func _on_destroy() -> void:
    queue_free()
    



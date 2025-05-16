class_name VillageElder extends Character

func _on_intereactable_selected() -> void:
	$AnimatedSprite2D/InteractIndicator.visible = true

func _on_intereactable_unselected() -> void:
	$AnimatedSprite2D/InteractIndicator.visible = false

class_name VillageElder extends Character
@onready var interact_indicator: Sprite2D = $AnimatedSprite2D/InteractIndicator

func give_item() -> void:
	interact_indicator.visible = false
	state_machine.change_state("giveitem")
	GameManager.given_mysterious_scroll = true

func _on_intereactable_selected() -> void:
	interact_indicator.visible = true

func _on_intereactable_unselected() -> void:
	interact_indicator.visible = false

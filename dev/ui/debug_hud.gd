class_name DebugHud
extends CanvasLayer

func _process(_delta: float) -> void:
	if PlayerManager.player:
		%PlayerHealth.text = "Health: %.0f" % PlayerManager.player.current_health

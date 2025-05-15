extends Node

const INVENTORY_DATA: InventoryData = preload("res://ui/inventory/player_inventory.tres")

var player: Player

func register(player_input: Player) -> void:
	player = player_input
	
func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

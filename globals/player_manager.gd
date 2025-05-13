extends Node

const INVENTORY_DATA: InventoryData = preload("res://ui/inventory/player_inventory.tres")

var player: Player

func register(player_input: Player) -> void:
	player = player_input

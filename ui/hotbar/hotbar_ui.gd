class_name HotbarUI extends Control

const HOTBAR_SLOT = preload("res://ui/hotbar/hotbar_slot.tscn")

@export var data: InventoryData
@onready var hotbar: CanvasLayer = $".."

func _ready() -> void:
	clear_inventory()
	update_inventory()
	PlayerManager.INVENTORY_DATA.changed.connect(_on_inventory_changed)

func _on_inventory_changed() -> void:
	clear_inventory()
	update_inventory()
	
func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()
		
func update_inventory() -> void:
	for s in data.slots:
		#might not need
		var new_slot = HOTBAR_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		

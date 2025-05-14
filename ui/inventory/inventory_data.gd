class_name InventoryData extends Resource

@export var slots: Array[SlotData]

func _init() -> void:
	connect_slots()
	
func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)
			
func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
	
func add_item(item: ItemData, quantity: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				#handles stacking of items
				s.quantity += quantity
				emit_changed()
				return true
		
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = quantity
			slots[i] = new
			new.changed.connect(slot_changed)
			emit_changed()
			return true
	#need to make code for max quantity, or stackable/unstackable items
	print("inventory was full")
	return false

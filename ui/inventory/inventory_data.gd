class_name InventoryData extends Resource

@export var slots: Array[SlotData]


func add_item(item: ItemData, quantity: int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				#handles stacking of items
				s.quantity += quantity
				return true
		else:
			var new_slot_data = SlotData.new()
			new_slot_data.item_data = item
			new_slot_data.quantity = quantity
			slots.append(new_slot_data)
			return true
	#need to make code for max quantity, or stackable/unstackable items
	print("inventory was full")
	return false

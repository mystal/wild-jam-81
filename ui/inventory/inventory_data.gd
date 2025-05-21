class_name InventoryData extends Resource

## Array of inventory slots (each holds an InventorySlot resource)
@export var slots: Array[InventorySlot]
## Emitted whenever the inventory changes
signal updated

## Attempts to insert an item into the inventory.
## - If the item is unique, only one can exist in the inventory.
## - If possible, stacks the item up to its max_stack.
## - Otherwise, adds the item to a new empty slot.
func insert(item: ItemData) -> void:
    # Unique item: only allow one in inventory
    if item.unique:
        for slot in slots:
            if slot.item == item:
                return # Already have this unique item, do not add
    # Try to stack if possible
    for slot in slots:
        if slot.item == item and slot.quantity < item.max_stack:
            slot.quantity += 1
            updated.emit()
            return
    # Find empty slot
    for i in range(slots.size()):
        if slots[i].item == null:
            slots[i].item = item
            slots[i].quantity = 1
            updated.emit()
            return
    # If no empty slot, do nothing (inventory full)

## Removes the given inventory slot from the inventory (replaces with a new empty slot)
func remove_slot(inventory_slot: InventorySlot) -> void:
    var index = slots.find(inventory_slot)
    if index < 0:
        return
    slots[index] = InventorySlot.new()
    updated.emit()

## Inserts the given inventory slot at the specified index
func insert_slot(index: int, inventory_slot: InventorySlot) -> void:
    # var old_index = slots.find(inventory_slot)
    # remove_slot(old_index)
    slots[index] = inventory_slot
    updated.emit()
class_name InventorySlotUI extends Button

##References to UI elements for the slot
@onready var background: Sprite2D = $Background
@onready var container: CenterContainer = $CenterContainer

##Reference to the player's inventory data
@onready var inventory: InventoryData = PlayerManager.INVENTORY_DATA

##Holds the ItemStackUI instance currently in this slot
var item_stack_ui: ItemStackUI
##The index of this slot in the inventory
var index: int

##Inserts an ItemStackUI into this slot and updates visuals
func insert(item_stack_ui_input: ItemStackUI) -> void:
    item_stack_ui = item_stack_ui_input
    background.frame = 1
    container.add_child(item_stack_ui)

    # If the item is already in the correct slot, do nothing
    if item_stack_ui.inventory_slot == null || inventory.slots[index] == item_stack_ui.inventory_slot:
        return
    
    # Otherwise, insert the item into the inventory at this slot
    inventory.insert_slot(index, item_stack_ui.inventory_slot)

##Removes and returns the ItemStackUI from this slot, updating visuals
func take_item() -> ItemStackUI:
    var item = item_stack_ui

    inventory.remove_slot(item_stack_ui.inventory_slot)
    return item

##Returns true if this slot is empty (no ItemStackUI)
func is_empty() -> bool:
    return item_stack_ui == null

func clear() -> void:
    if item_stack_ui != null:
        container.remove_child(item_stack_ui)
        item_stack_ui = null
        background.frame = 0

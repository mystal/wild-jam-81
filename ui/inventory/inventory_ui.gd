class_name InventoryUI extends Control

##Tracks if the inventory UI is open
var is_open: bool = false

##References to slot UI nodes, inventory data, and the item stack UI scene
@onready var hotbar_slots: Array = $NinePatchRect/HBoxContainer.get_children()
@onready var slots: Array = hotbar_slots + $NinePatchRect/GridContainer.get_children()
@onready var inventory: InventoryData = PlayerManager.INVENTORY_DATA
@onready var item_stack_ui_scene = preload("res://ui/inventory/item_stack_ui.tscn")

##The currently selected item stack UI (for drag-and-drop)
var item_selected: ItemStackUI = null

const ITEM_PICKUP_SCENE = preload("res://entities/items/item_pickup.tscn")

##Updates the visual state of all inventory slots to match the inventory data
func update() -> void:
    for i in range(min(inventory.slots.size(), slots.size())):
        var slot_ui: InventorySlotUI = slots[i] as InventorySlotUI
        var inventory_slot: InventorySlot = inventory.slots[i]
        # If the slot is empty, set background to empty and skip
        if inventory_slot == null || inventory_slot.item == null:
            slot_ui.background.frame = 0
            slots[i].clear()
            continue
        # Otherwise, ensure the slot has an ItemStackUI and update it
        var item_stack_ui: ItemStackUI = slot_ui.item_stack_ui
        if item_stack_ui == null:
            item_stack_ui = item_stack_ui_scene.instantiate() as ItemStackUI
            slot_ui.insert(item_stack_ui)

        item_stack_ui.inventory_slot = inventory_slot
        item_stack_ui.update()

##Called when the node is added to the scene; sets up slot signals and initial state
func _ready() -> void:
    connect_slots()
    inventory.updated.connect(update)
    update()

##Connects each slot's pressed signal to the handler, binding the slot as an argument
func connect_slots() -> void:
    for i in range(slots.size()):
        var slot = slots[i] as InventorySlotUI
        slot.index = i

        var callable = Callable(_on_slot_pressed)
        callable = callable.bind(slot)
        slot.pressed.connect(callable)

##Opens the inventory UI and pauses the game
func open() -> void:
    visible = true
    is_open = true
    get_tree().paused = true

##Closes the inventory UI and unpauses the game
func close() -> void:
    visible = false
    is_open = false
    get_tree().paused = false

##Handles logic when a slot is pressed (clicked)
func _on_slot_pressed(slot) -> void:
    # If the slot is empty and an item is selected, insert the item
    if slot.is_empty():
        if item_selected == null:
            return
        insert_item_in_slot(slot)
        return
    
    # If no item is selected, take the item from the slot
    if item_selected == null:
        take_item_from_slot(slot)
        return
    
    if slot.item_stack_ui.inventory_slot.item.name == item_selected.inventory_slot.item.name:
        # If the items are the same, try to stack them
        stack_items(slot)
        return

    # Otherwise, swap the selected item with the slot's item
    swap_items(slot)
    
##Updates the position of the selected item to follow the mouse (for drag-and-drop)
func update_selected_item():
    if item_selected == null:
        return
    var mouse_pos = get_global_mouse_position()
    item_selected.global_position = mouse_pos - item_selected.size / 2

##Called every input event; updates the selected item's position if dragging
func _input(_event: InputEvent) -> void:
    if item_selected != null && (Input.is_action_just_pressed("right_click") || Input.is_action_just_pressed("left_click")):
        # If right-clicked, drop the item
        drop_item()
    update_selected_item()

func drop_item():
    if item_selected == null:
        return

    ###TODO: FIX THIS
    # Instance the ItemPickup scene
    # var item_pickup: ItemPickup = ITEM_PICKUP_SCENE.instantiate() as ItemPickup
    #
    # # Set the item data and quantity
    # item_pickup.set_item_data(item_selected.inventory_slot.item)
    # # Optionally, set quantity if your ItemPickup supports it
    # # item_pickup.quantity = item_selected.inventory_slot.quantity

    # # Set the position to mouse position
    # item_pickup.global_position = get_global_mouse_position()

    # # Add the pickup to the scene
    # get_parent().call_deferred("add_child", item_pickup)

    # Remove the item from inventory and UI
    inventory.remove_slot(item_selected.inventory_slot)
    remove_child(item_selected)
    item_selected = null

##Takes the item from the given slot and sets it as the selected item
func take_item_from_slot(slot: InventorySlotUI):
    item_selected = slot.take_item()
    add_child(item_selected)
    update_selected_item()

##Inserts the selected item into the given slot and clears the selection
func insert_item_in_slot(slot: InventorySlotUI):
    var item = item_selected

    remove_child(item_selected)
    item_selected = null

    slot.insert(item)

##Swaps the selected item with the item in the given slot
func swap_items(slot: InventorySlotUI):
    var item = slot.take_item()
    insert_item_in_slot(slot)
    item_selected = item
    add_child(item_selected)
    update_selected_item()

##Attempts to stack the selected item with the slot's item, or swaps if not possible
func stack_items(slot: InventorySlotUI):
    var slot_item: ItemStackUI = slot.item_stack_ui
    var max_amount = slot_item.inventory_slot.item.max_stack
    var total_amount = slot_item.inventory_slot.quantity + item_selected.inventory_slot.quantity

    # If the slot is already full, swap items
    if slot_item.inventory_slot.quantity == max_amount:
        swap_items(slot)
        return
    
    # If stacking fits, combine and clear selection
    if total_amount <= max_amount:
        slot_item.inventory_slot.quantity = total_amount
        remove_child(item_selected)
        item_selected = null
    else:
        # Otherwise, fill the slot and leave the remainder selected
        slot_item.inventory_slot.quantity = max_amount
        item_selected.inventory_slot.quantity = total_amount - max_amount
    
    slot_item.update()
    if item_selected != null:
        item_selected.update()


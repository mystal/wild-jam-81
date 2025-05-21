class_name ItemStackUI extends Panel
@onready var item_icon: Sprite2D = $ItemIcon
@onready var quantity_label: Label = $Label

var inventory_slot: InventorySlot

func update() -> void:
    if inventory_slot == null || inventory_slot.item == null:
        return
    item_icon.visible = true
    item_icon.texture = inventory_slot.item.texture

    if inventory_slot.quantity > 1:
        quantity_label.visible = true
        quantity_label.text = str(inventory_slot.quantity)
    else:
        quantity_label.visible = false

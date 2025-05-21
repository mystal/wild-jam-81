class_name HotBarSlotUI extends Button

@onready var background: Sprite2D = $Background
@onready var item_stack_ui: ItemStackUI = $CenterContainer/Panel
##Reference to the player's inventory data
@onready var inventory: InventoryData = PlayerManager.INVENTORY_DATA
@export var slot_number: int = 0
@onready var container: CenterContainer = $CenterContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
    pass

func _on_mouse_exited() -> void:
    pass

func _input(event: InputEvent) -> void:
    if (event.is_action_pressed("hotbar_" + str(slot_number))):
        if item_stack_ui.inventory_slot.item == null:
            return
        if item_stack_ui.inventory_slot:
            if item_stack_ui.inventory_slot.item:
                var was_used = item_stack_ui.inventory_slot.item.use()
                if was_used == false:
                    return
                item_stack_ui.inventory_slot.quantity -= 1
                if item_stack_ui.inventory_slot.quantity <= 0:
                    var item = item_stack_ui
                    inventory.remove_slot(item_stack_ui.inventory_slot)
                    container.remove_child(item)
                    background.frame = 0
                else:
                    item_stack_ui.update()
                # quantity_label.text = str(item_stack_ui.inventory_slot.quantity)

func update_to_slot(slot: InventorySlot) -> void:
    if slot.item == null:
        item_stack_ui.visible = false
        background.frame = 0
        return
    
    item_stack_ui.inventory_slot = slot
    item_stack_ui.update()
    item_stack_ui.visible = true
    background.frame = 1

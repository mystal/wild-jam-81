class_name HotbarSlotUI extends Button

var slot_data: SlotData : set = set_slot_data

@onready var quantity_label: Label = $QuantityLabel
@onready var item_texture_rect: TextureRect = $ItemTextureRect
@onready var item_description_label: Label = $"../../ItemDescriptionLabel"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_texture_rect.texture = null
	quantity_label.text = ""
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func set_slot_data(value: SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	item_texture_rect.texture = slot_data.item_data.texture
	quantity_label.text = str(slot_data.quantity)
	
func _on_mouse_entered() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			item_description_label.text = slot_data.item_data.description
	
func _on_mouse_exited() -> void:
	item_description_label.text = ""

class_name HotbarUI extends Control

const HOTBAR_SLOT = preload("res://ui/hotbar/hotbar_slot.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

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
	var hotbar_slot_number: int = 0
	for s in data.slots:
		#might not need
		var new_slot = HOTBAR_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_number = hotbar_slot_number
		hotbar_slot_number += 1
		new_slot.slot_data = s
		
func play_audio(audio: AudioStream) -> void:
	audio_stream_player_2d.stream = audio
	audio_stream_player_2d.play()

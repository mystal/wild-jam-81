class_name CharacterGiveItem extends State

@export var anim_name: String = "item_up"
@export var item_to_give: ItemData
@export_category("AI")
@export var state_duration: float = 2.0
@export var next_state: State

const PICKUP = preload("res://entities/items/item_pickup.tscn")

var _timer: float = 0.0

func enter() -> void:
	character.velocity = Vector2.ZERO
	_timer = state_duration
	character.animated_sprite_2d.play(anim_name)
	character.animated_sprite_2d.animation_finished.connect(exit)

func exit() -> void:
	drop_item()

func physics_update(_delta: float) -> void:
	_timer -= _delta
	if _timer <= 0:
		state_machine.change_state(next_state.name.to_lower())
		
func drop_item() -> void:
	var drop: ItemPickup = PICKUP.instantiate() as ItemPickup
	drop.set_item_data(item_to_give)
	character.get_parent().call_deferred("add_child", drop)
	drop.global_position = character.global_position
	drop.velocity = character.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)

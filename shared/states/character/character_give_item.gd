class_name CharacterGiveItem extends State

@export var anim_name: String = "item_up"
@export var item_pickup: ItemPickup
@export var state_duration: float = 2.0
@export var next_state: State


var _timer: float = 0.0

func enter() -> void:
	character.velocity = Vector2.ZERO
	_timer = state_duration
	character.animated_sprite_2d.play(anim_name)
	item_pickup.visible = true
	await get_tree().create_timer(state_duration).timeout
	state_machine.change_state(next_state.name.to_lower())

func exit() -> void:
	drop_item()

		
func drop_item() -> void:
	# character.get_parent().call_deferred("add_child", item_pickup)
	item_pickup.velocity = character.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)

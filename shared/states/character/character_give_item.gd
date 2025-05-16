class_name CharacterGiveItem extends State

@export var anim_name: String = "give_item"
@export_category("AI")
@export var state_duration: float = 2.0
@export var next_state: State
@onready var item_to_give: Sprite2D = $"../../ItemToGive"

var _timer: float = 0.0

func enter() -> void:
	character.velocity = Vector2.ZERO
	_timer = state_duration
	character.animated_sprite_2d.play(anim_name + "_" + character.get_last_direction())
	item_to_give.visible = true

func exit() -> void:
	item_to_give.visible = false

func physics_update(_delta: float) -> void:
	_timer -= _delta
	if _timer <= 0:
		state_machine.change_state(next_state.name.to_lower())
		

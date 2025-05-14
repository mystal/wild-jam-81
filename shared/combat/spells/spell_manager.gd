class_name SpellManager extends Node

const FIRE_SPELL_SCENE = preload("res://entities/spells/fire/fire_spell.tscn")
@onready var player: Player = $".."
@onready var state_machine: StateMachine = $"../StateMachine"

enum Spells {
	FIRE_SPELL, 
	ICE_SPELL, 
	EARTH_SPELL
}

func _physics_process(delta: float) -> void:
	if not player.animated_sprite_2d.is_playing():
		state_machine.change_state("idle")

func cast_spell(item_effect: ItemEffect) -> void:
	if item_effect is FireSpellEffect:
		cast_fire_spell(item_effect)
		
func cast_fire_spell(item_effect) -> void:
	var _fire_spell = FIRE_SPELL_SCENE.instantiate() as FireSpell
	player.add_sibling(_fire_spell)
	
	_fire_spell.position = player.global_position
	
	var cast_direction = player.direction
	if cast_direction == Vector2.ZERO:
		cast_direction = player.last_direction
	player.animated_sprite_2d.play("shoot_" + player.get_last_direction())
	_fire_spell.cast(item_effect, cast_direction)
	

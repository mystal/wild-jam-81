class_name CharacterDeath extends State

@export var anim_name: String = "death"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export_category("Item Drops")
@export var drops: Array[DropData]

const PICKUP = preload("res://entities/items/item_pickup.tscn")
const DIRECTIONS = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var _damage_position: Vector2
var _direction: Vector2

func enter() -> void:
	character.death_animation.animation_finished.connect(_on_death_animation_finished)
	character.invulnerable = true
	_damage_position = character.hurt_box.global_position
	_direction = character.global_position.direction_to(_damage_position)
	character.last_direction = _direction
	character.velocity = _direction * knockback_speed
	character.animated_sprite_2d.visible = false
	character.death_animation.visible = true
	character.death_animation.play("death")
	drop_items()

func physics_update(_delta: float) -> void:
	character.velocity -= character.velocity * decelerate_speed * _delta

func _on_death_animation_finished() -> void:
	character.queue_free()

func drop_items() -> void:
	if drops.size() == 0:
		return
	# Spawn the drops at the character's position
	# and add them to the current scene
	for drop in drops:
		if drop == null || drop.item == null:
			continue
		var drop_count = drop.get_drop_count()
		for j in drop_count:
			var item: ItemPickup = PICKUP.instantiate() as ItemPickup
			item.set_item_data(drop.item)
			character.get_parent().call_deferred("add_child", item)
			item.global_position = character.global_position
			item.velocity = character.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)


		

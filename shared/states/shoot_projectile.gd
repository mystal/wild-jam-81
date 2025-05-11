class_name ShootProjectile extends State

@export var projectile: PackedScene
@onready var projectile_weapon: ProjectileWeapon = $"../../ProjectileWeapon"

func enter() -> void:
	player.is_attacking = true
	player.can_attack = false

	player.animated_sprite_2d.play("shoot_" + player.get_last_direction())
	fire_projectile()

func exit() -> void:
	player.is_attacking = false
	player.can_attack = true

func physics_update(_delta: float) -> void:
	if not player.animated_sprite_2d.is_playing():
		state_machine.change_state("idle")

func fire_projectile() -> void:
	var new_projectile := projectile.instantiate()
	new_projectile.position = projectile_weapon.global_position
	var direction := (player.get_global_mouse_position() - projectile_weapon.global_position).normalized()
	new_projectile.rotation = direction.angle()

	get_tree().current_scene.add_child(new_projectile)

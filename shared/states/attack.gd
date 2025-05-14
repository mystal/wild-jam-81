class_name Attack extends State


func enter() -> void:
	player.is_attacking = true
	player.can_attack = false
	player.animated_sprite_2d.play("attack_" + player.get_last_direction())

	await get_tree().create_timer(0.075).timeout


func exit() -> void:
	player.is_attacking = false
	player.can_attack = true

func physics_update(_delta: float) -> void:
	player.velocity -= player.velocity * player.decelerate_speed * _delta

	if not player.animated_sprite_2d.is_playing():
		state_machine.change_state("idle")

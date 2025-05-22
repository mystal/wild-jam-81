class_name SlimeBossChase extends CharacterChase

func enter() -> void:
	_timer = state_aggro_duration
	character.animated_sprite_2d.play(anim_name)
	if attack_area:
		attack_area.monitoring = true

func physics_update(_delta: float) -> void:
	_jump_cooldown -= _delta
	var new_direction: Vector2 = character.global_position.direction_to(PlayerManager.player.global_position)
	_direction = lerp(_direction, new_direction, turn_rate)
	character.velocity = _direction * chase_speed
	character.last_direction = _direction
	if character.last_direction == _direction:
		character.animated_sprite_2d.play(anim_name)
	
	if _jump_cooldown <= 0:
		_jump_cooldown = randf_range(1.0, 2.5)
		state_machine.change_state("jump")
		return
	
	if !_can_see_player:
		_timer -= _delta
		if _timer <= 0:
			state_machine.change_state(next_state.name.to_lower())
	else:
		_timer = state_aggro_duration

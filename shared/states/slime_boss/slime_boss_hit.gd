class_name SlimeBossHit extends CharacterHit

func enter() -> void:
    character.animated_sprite_2d.animation_finished.connect(_on_animation_finished)
    character.invulnerable = true
    _animation_finished = false
    _damage_position = character.hurt_box.global_position
    _direction = character.global_position.direction_to(_damage_position)
    # character.last_direction = _direction
    # character.velocity = _direction * knockback_speed
	
    character.animated_sprite_2d.play("hit")
    
func _on_animation_finished() -> void:
    _animation_finished = true
    character.animated_sprite_2d.animation_finished.disconnect(_on_animation_finished)

# func physics_update(_delta: float) -> void:
    if _animation_finished == true:
        state_machine.change_state(next_state.name.to_lower())
	# character.velocity -= character.velocity * decelerate_speed * _delta

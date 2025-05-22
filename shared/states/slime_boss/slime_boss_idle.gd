class_name SlimeBossIdle extends CharacterIdle

func enter() -> void:
    character.velocity = Vector2.ZERO
    _timer = randf_range(state_duration_min, state_duration_max)
    character.animated_sprite_2d.play(anim_name)
		

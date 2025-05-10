class_name Walk extends State

func physics_update(_delta: float) -> void:
	if player.direction == Vector2.ZERO:
		state_machine.change_state("idle")
		return
	player.last_direction = player.direction.normalized()
	player.velocity = player.last_direction * player.speed
	
	player.animated_sprite_2d.play("walk_" + player.get_last_direction())
	
	if Input.is_action_just_pressed("attack") and player.can_attack:
		state_machine.change_state("attack")

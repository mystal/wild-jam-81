class_name EvilEye
extends Character



#var facing: Vector2i = Vector2i.DOWN
#
#func _physics_process(_delta: float) -> void:
	#var player: Player
	#var direction := Vector2.ZERO
	#var players := get_tree().get_nodes_in_group("player")
	#if players:
		#player = players[0] as Player
#
	#if player:
		## Move slowly toward player
		#direction = (player.global_position - global_position).normalized()
		#velocity = direction * speed
	#else:
		#velocity = Vector2.ZERO
#
	#move_and_slide()
#
	## Update animation
	#if direction:
		#if absf(direction.x) > absf(direction.y):
			#facing = Vector2i.RIGHT * signf(direction.x)
		#else:
			#facing = Vector2i.DOWN * signf(direction.y)
	#match facing:
		#Vector2i.LEFT:
			#$AnimatedSprite2D.play("idle_left")
		#Vector2i.RIGHT:
			#$AnimatedSprite2D.play("idle_right")
		#Vector2i.UP:
			#$AnimatedSprite2D.play("idle_up")
		#Vector2i.DOWN:
			#$AnimatedSprite2D.play("idle_down")

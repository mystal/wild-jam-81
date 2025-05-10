class_name Attack extends State
@onready var attack_hurt_box: Area2D = %AttackHurtBox






func enter() -> void:
	player.is_attacking = true
	player.can_attack = false
	player.animated_sprite_2d.play("attack_" + player.get_last_direction())
	
	await get_tree().create_timer(0.075).timeout
	attack_hurt_box.monitoring = true
	

func exit() -> void:
	player.is_attacking = false
	player.can_attack = true
	attack_hurt_box.monitoring = false

func physics_update(_delta: float) -> void:
	player.velocity -= player.velocity * player.decelerate_speed * _delta
	
	if not player.animated_sprite_2d.is_playing():
		state_machine.change_state("idle")

class_name Idle extends State

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.animated_sprite_2d.play("idle_" + player.get_last_direction())

func physics_update(_delta: float) -> void:
	if player.direction != Vector2.ZERO:
		state_machine.change_state("walk")

	if Input.is_action_just_pressed("attack") and player.can_attack:
		state_machine.change_state("attack")

	if Input.is_action_just_pressed("shoot") and player.can_attack:
		state_machine.change_state("shootprojectile")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var overlapping_interactables := player.interaction_area.get_overlapping_areas()
		if overlapping_interactables:
			var interactable := overlapping_interactables[0] as Interactable
			if interactable:
				interactable.interact()

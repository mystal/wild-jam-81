class_name LanternAttack
extends State

@export var fire_rate: float = 1.0
@export var projectile: PackedScene

var _fire_timer: Timer

func enter() -> void:
	if not _fire_timer:
		_fire_timer = Timer.new()
		_fire_timer.autostart = false
		_fire_timer.one_shot = false
		_fire_timer.timeout.connect(_on_timer_timeout)
		add_child(_fire_timer)

	_fire_timer.paused = false
	_fire_timer.start(1.0 / fire_rate)

func exit() -> void:
	_fire_timer.stop()

func _on_timer_timeout() -> void:
	if not projectile:
		return

	for dir in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
		var new_projectile := projectile.instantiate()
		new_projectile.position = character.global_position
		new_projectile.rotation = dir.angle()
		new_projectile.faction = character.faction
		add_sibling(new_projectile)

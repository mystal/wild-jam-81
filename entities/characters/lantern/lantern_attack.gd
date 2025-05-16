class_name LanternAttack
extends State

@export var fire_rate: float = 1.0

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
	pass

func _on_timer_timeout() -> void:
	print("pew")

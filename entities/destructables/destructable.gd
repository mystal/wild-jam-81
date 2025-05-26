@tool
class_name Destructable extends StaticBody2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var particle: GPUParticles2D = $GPUParticles2D
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox


func _ready() -> void:
	health.died.connect(_on_health_died)
	hurt_box.damaged.connect(_on_hurt_box_damaged)

func _on_hurt_box_damaged(hit_box: HitBox) -> void:
	health.take_damage(hit_box.damage)
	damage_vfx()

func _on_health_died() -> void:
	collision_layer = 0
	await damage_vfx()
	sprite.visible = false
	hurt_box.monitoring = false
	# await get_tree().create_timer(2.0).timeout
	queue_free()


func damage_vfx():
	flash()
	particle.restart()
	await shake()

func flash(time = 0.2):
	sprite.modulate = Color(5,5,5)
	await get_tree().create_timer(time).timeout
	sprite.modulate = Color.WHITE

func shake(intensity := 1.0,time := 0.1):
	var tween = create_tween()
	tween.tween_property(sprite,"offset",Vector2(-1,-1)*intensity,time/3)
	tween.tween_property(sprite,"offset",Vector2.LEFT*intensity,time/3)
	tween.tween_property(sprite,"offset",Vector2.ZERO,time/3)
	await tween.finished

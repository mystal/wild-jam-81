@tool
class_name EnemySpawner extends Area2D

@export var enemies: Array[EnemySpawnData]
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	if Engine.is_editor_hint():
		sprite_2d.visibile = true
	
	for enemy_data in enemies:
		for count in enemy_data.max_number:
			var enemy = enemy_data.scene.instantiate() as Character
			enemy.position = generate_random_position()
			await get_tree().create_timer(enemy_data.spawn_delay).timeout
			get_tree().current_scene.add_child(enemy)

func generate_random_position() -> Vector2:
	##assume collision shape is a circle:
	var shape = collision_shape_2d.shape as CircleShape2D
	var radius = shape.radius
	var angle = randf() * TAU
	var r = sqrt(randf()) * radius  # Uniform distribution
	var offset = Vector2(cos(angle), sin(angle)) * r
	return global_position + offset

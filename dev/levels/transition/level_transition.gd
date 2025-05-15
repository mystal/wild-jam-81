@tool
class_name LevelTransition extends Area2D

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_file("*.tscn") var level
@export var target_transition_area: String = "LevelTransition"

@export_category("Collision Area Settings")
@export var side: SIDE = SIDE.LEFT
@export var snap_to_grid: bool = false
@export_range(1, 12, 1, "or_greater") var size: int = 2

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

class_name PlayerCamera extends Camera2D

@export var tile_map_layer: TileMapLayer

func _ready() -> void:
	var map_rect := tile_map_layer.get_used_rect()
	var cell_quadrant_size := tile_map_layer.rendering_quadrant_size
	var world_size_in_px = map_rect.size * cell_quadrant_size
	limit_right = world_size_in_px.x
	limit_bottom = world_size_in_px.y
	limit_left = 0
	limit_top = 0

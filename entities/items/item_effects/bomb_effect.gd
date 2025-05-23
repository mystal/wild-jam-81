class_name BombEffect extends ItemEffect

@export var damage: int = 5
@export var area_of_effect: int = 50
@export var explosion_timer: int = 5
@export var flash_timer: int = 3

const BOMB_SCENE = preload("res://entities/items//bomb/bomb.tscn")

func use() -> void:
    var player = PlayerManager.player
    var _bomb = BOMB_SCENE.instantiate() as Bomb
    player.add_sibling(_bomb)
    _bomb.position = PlayerManager.player.global_position
    player.animated_sprite_2d.play("shoot_" + PlayerManager.player.get_last_direction())
    _bomb.place(self)
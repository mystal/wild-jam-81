class_name Biome extends Area2D

@export var weather_effects: Array[WeatherEffect] = []

func _ready() -> void:
    for effect in weather_effects:
        effect.start()
    


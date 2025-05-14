class_name HealEffect extends ItemEffect

@export var heal_amount: int = 1
@export var audio: AudioStream

func use() -> void:
	PlayerManager.player.update_hp(heal_amount)
	#Hotbar.play_audio()
	#play sound

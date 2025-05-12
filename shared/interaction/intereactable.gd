class_name Interactable
extends Area2D

@export var dialogue: DialogueResource

func interact() -> void:
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue)

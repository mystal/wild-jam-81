class_name Interactable
extends Area2D

@export var dialogue: DialogueResource

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_finished)
	
func interact() -> void:
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue)
		
func _on_dialogue_started(resource: DialogueResource) -> void:
	if resource == dialogue:
		get_tree().paused = true
	
func _on_dialogue_finished(resource: DialogueResource) -> void:
	if resource == dialogue:
		get_tree().paused = false

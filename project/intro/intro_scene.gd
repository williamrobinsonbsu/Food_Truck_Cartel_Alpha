extends Control


func _ready():
	var curr = DialogueManager.show_example_dialogue_balloon(load("res://intro/dialogue.dialogue"), "intro")
	await DialogueManager.dialogue_ended
	self.hide()
	get_tree().change_scene_to_file("res://levels/beach.tscn")

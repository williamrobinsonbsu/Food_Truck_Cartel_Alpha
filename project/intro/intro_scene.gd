extends Control


func _ready():
	await DialogueManager.show_example_dialogue_balloon(load("res://intro/dialogue.dialogue"), "intro").child_exiting_tree
	self.hide()

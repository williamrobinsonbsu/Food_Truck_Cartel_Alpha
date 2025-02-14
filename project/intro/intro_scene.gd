extends Control


func _ready():
	await DialogueManager.dialogue_ended
	self.hide()
	get_tree().change_scene_to_file("res://levels/beach.tscn")

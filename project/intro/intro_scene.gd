extends Control


@onready var sprite: Sprite2D = $Sprite2D


func _ready():
	if Global.end == true:
		$Label2.hide()
		print("yea")
		DialogueManager.show_example_dialogue_balloon(load("res://intro/end.dialogue"), "intro")
		sprite.texture = load("res://customer/dog/CleanUpDog.png")
		await DialogueManager.dialogue_ended
		Global.end = false
		get_tree().change_scene_to_file("res://menus/road_map.tscn")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://intro/dialogue.dialogue"), "intro")
		await DialogueManager.dialogue_ended
		get_tree().change_scene_to_file("res://levels/beach.tscn")
	self.hide()


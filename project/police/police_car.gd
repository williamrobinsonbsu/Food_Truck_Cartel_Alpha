extends Node3D


@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready():
	anim.play("drive")
	await anim.animation_finished
	queue_free()

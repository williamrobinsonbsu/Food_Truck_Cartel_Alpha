extends StaticBody3D

var scene = preload("res://ingredients/patty.tscn")
var cooking := false
@onready var timer_path := preload("res://ingredients/queue_free_timer.tscn")
var timer: Timer
var burn_timer : Timer

func _ready():
	timer = timer_path.instantiate()
	add_child(timer)
	burn_timer = timer_path.instantiate()
	add_child(burn_timer)
	#timer.paused = true

func use(ingredient):
	if ingredient.has_method("name") and ingredient.name() == "patty_raw" and cooking == false:
		ingredient.to_cook()
		$PattyRaw.show()
		Global.grill_used += 1
		cooking = true
		ingredient.audio_play_grill()
		#$PattyRaw.set_collision_layer_value(1, false)
		ingredient.queue_free()
		await get_tree().create_timer(5).timeout
		$PattyRaw.hide()
		var patty = scene.instantiate()
		add_child(patty)
		patty.position = %CookedPatty.position
		cooking = false
	else:
		pass
		
		


func _on_grill_top_body_entered(body):
		assert(body!=null, "Argument may not be null")
		if body.has_method("cooks") and body.cooks() == false:
			use(body)
		if body.has_method("name") and body.name() == "patty":
			#body.add_smoke()
			if body.is_smoking == false:
				timer.paused = false
				timer.start(1)
				timer.timeout.connect(func():
					if body != null:
						body.add_smoke()
						body.is_smoking = true
						timer.paused = true
						_burn(body)
						#timer.paused = true
						)
			else:
				_burn(body)
				
		
func _burn(body):
	burn_timer.paused = false
	burn_timer.start(1)
	burn_timer.timeout.connect(func():
		if body != null:
			body.queue_free())

func _on_grill_top_body_exited(body):
	timer.paused = true
	burn_timer.paused = true

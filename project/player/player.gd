extends CharacterBody3D


#signal pickup
#signal drop
#signal pause_clicked

signal hover

var totalPickup = 0


const SPEED = 5.0

@onready var interaction := $Camera3D/Interaction
@onready var hand := $Camera3D/Hand
@onready var loading_screen: Control = $LoadingScreen

var index = 1
var tex_array = [load("res://player/Day_Beginning.png"),load("res://player/Day_Mid.png"),load("res://player/Day_Late.png"),load("res://player/Day_End.png")]
var picked_object
var pull_power = 10


var true_speed = SPEED
var is_crouching = false



func _ready():
	await get_tree().create_timer(2).timeout
	loading_screen.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x) * 0.25)
		$Camera3D.rotate_x(deg_to_rad(-event.relative.y) * 0.25)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x,deg_to_rad(-80), deg_to_rad(50))
	
	if Input.is_action_just_pressed("left_click"):
		var collider = interaction.get_collider()
		#print("Picked Status: " + str(picked_object))
		#print(collider)
		if collider is RigidBody3D and picked_object == null:
			pick_object()
		elif collider is StaticBody3D and picked_object == null:
			if collider.has_method("pick_item"):
				pick_object()
				if picked_object.has_method("audio_play"):
					picked_object.audio_play()
				else:
					var audio_stream_player := AudioStreamPlayer.new()
					audio_stream_player.bus = "Sound"
					audio_stream_player.stream = load("res://audio/newSounds/pick_up.wav")
					get_parent().add_child(audio_stream_player)
					audio_stream_player.play()
					audio_stream_player.finished.connect(func():
						audio_stream_player.queue_free()
						)
		
		if collider != null:		
			if collider.has_method("use") and picked_object != null:
				collider.use(picked_object)
			
			if collider.has_method("door_close"):
				collider.door_close()
				
			if collider.has_method("place"):
				collider.place(picked_object)
				
			if collider.has_method("reset"):
				collider.reset()
				
			elif picked_object != null and collider.has_method("delete_item"):
					picked_object.queue_free()
					picked_object = null
					
	if Input.is_action_just_pressed("right_click"):
		if picked_object != null:
			drop_object()
#
func _physics_process(_delta):
	self.position.y = 1.226
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if picked_object != null:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		picked_object.set_linear_velocity((b-a) * pull_power)
	if Input.is_action_just_pressed("crouch"):
	
		if is_crouching == false:
			movementStateChange("crouch")
			print("Crouch: " + str(Global.crouch))
			Global.crouch += 1
		elif is_crouching == true:
			movementStateChange("uncrouch")
			
	move_and_slide()
	
	if Input.is_action_just_pressed("pause"):
		#pause_clicked.emit()
		get_tree().paused = true
		$Pause/PauseMenu.show_pause_menu()
		await $Pause/PauseMenu.dismissed
		get_tree().paused = false
	
func movementStateChange(changeType):
	match changeType:
		"crouch":
			$AnimationPlayer.play("crouch_animation")
			is_crouching = true
		"uncrouch":
			$AnimationPlayer.play_backwards("crouch_animation")
			is_crouching = false

func pick_object():
	var collider = interaction.get_collider()
	if collider != null and collider is RigidBody3D:
		picked_object = collider
		Global.pick_up += 1
		print("Pick: " + str(Global.pick_up))
	elif collider != null and collider is StaticBody3D and collider.has_method("pick_item"):
		Global.pick_up += 1
		picked_object = collider.pick_item()
		print("Pick: " + str(Global.pick_up))
		
	if picked_object.has_method("picked"):
		picked_object.picked(true)
		

func drop_object():
	if picked_object != null:
		Global.drop += 1
		print("Drop: " + str(Global.drop))
		if picked_object.has_method("picked"):
			var audio_stream_player := AudioStreamPlayer.new()
			audio_stream_player.bus = "Sound"
			audio_stream_player.stream = load("res://audio/newSounds/pick_up.wav")
			get_parent().add_child(audio_stream_player)
			audio_stream_player.play()
			audio_stream_player.finished.connect(func():
				audio_stream_player.queue_free()
				)
			picked_object.picked(false)
		picked_object = null
		


func _on_day_timer_timeout():
	while index < 4:
		$Control/DayIcon.set_texture(tex_array[index])
		index += 1

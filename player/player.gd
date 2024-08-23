extends CharacterBody3D

const  speed = 5

@onready var interaction := $Camera3D/Interaction
@onready var hand := $Camera3D/Hand

var picked_object
var pull_power = 10

var crouch_speed = 20

var default_height = 1.5
var crouch_height = .5
var isCrouching = false


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x) * 0.25)
		$Camera3D.rotate_x(deg_to_rad(-event.relative.y) * 0.25)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x,deg_to_rad(-90), deg_to_rad(90))
	
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
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	if Input.is_action_just_pressed("crouch"):
		if isCrouching == false:
			movementStateChange("crouch")
		elif isCrouching == true:
			movementStateChange("uncrouch")
		
	if picked_object != null:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		picked_object.set_linear_velocity((b-a) * pull_power)

	move_and_slide()

func pick_object():
	var collider = interaction.get_collider()
	if collider != null and collider is RigidBody3D:
		picked_object = collider
	elif collider != null and collider is StaticBody3D and collider.has_method("pick_item"):
		picked_object = collider.pick_item()
		
	if picked_object.has_method("picked"):
		picked_object.picked(true)
		

func drop_object():
	if picked_object != null:
		if picked_object.has_method("picked"):
			picked_object.picked(false)
		picked_object = null

func movementStateChange(changeType):
	match changeType:
		"crouch":
			$AnimationPlayer.play("crouch")
			isCrouching = true
			
		"uncrouch":
			$AnimationPlayer.play_backwards("crouch")
			isCrouching = false

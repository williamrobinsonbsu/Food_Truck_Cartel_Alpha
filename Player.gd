extends CharacterBody3D


const SPEED = 5.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x)*0.25)
		$Camera3D.rotate_x(deg_to_rad(-event.relative.y)*0.25)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(_delta):
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

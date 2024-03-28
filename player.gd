extends CharacterBody3D

const SPEED = 5.0

@onready var interaction := $Camera3D/Interaction
@onready var hand := $Camera3D/Hand
#@onready var burger = $/root/World/Burger
#@onready var patty = $/root/World/Patty
#@onready var burger_patty = $"/root/World/Burger/Burger Patty"
#@onready var lettuce = $"/root/World/Lettuce"
#@onready var cut_lettuce = $"/root/World/Burger/Cut Lettuce"
#@onready var tomato = $"/root/World/Tomato"
#@onready var cut_tomato = $"/root/World/Burger/Cut Tomato"
#@onready var cheese = $"/root/World/Cheese"
#@onready var cut_cheese = $"/root/World/Burger/Cut Cheese"
#@onready var ketchup_bottle = $"/root/World/Ketchup Bottle"
#@onready var ketchup = $"/root/World/Burger/Ketchup"
#@onready var top_bun = $"/root/World/Top Bun"
#@onready var burger_bun = $"/root/World/Burger/Top Bun"
#
var picked_object
var pull_power = 10
#
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x) * 0.25)
		$Camera3D.rotate_x(deg_to_rad(-event.relative.y) * 0.25)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x,deg_to_rad(-60), deg_to_rad(60))
	
	if Input.is_action_just_pressed("left_click"):
		var collider = interaction.get_collider()
		if collider is RigidBody3D and picked_object == null:
			pick_object()
		elif collider is StaticBody3D:
				if collider.has_method("use"):
					collider.use()
				elif collider.has_method("pick_item"):
					pick_object()
				elif picked_object != null and collider.has_method("delete_item"):
					picked_object.queue_free()
#			if picked_object == patty:
#				if picked_object.cooked_patty == true:
#					patty.queue_free()
#					burger_patty.show()
#			if picked_object == lettuce:
#				if picked_object.cutted_lettuce == true:
#					lettuce.queue_free()
#					cut_lettuce.show()
#			if picked_object == tomato:
#				if picked_object.cutted_tomato == true:
#					tomato.queue_free()
#					cut_tomato.show()
#			if picked_object == cheese:
#				if picked_object.cutted_cheese == true:
#					cheese.queue_free()
#					cut_cheese.show()
#			if picked_object == ketchup_bottle:
#				ketchup.show()
#			if picked_object == top_bun:
#				top_bun.queue_free()
#				burger_bun.show()
#		
	if Input.is_action_just_pressed("right_click"):
		if picked_object != null:
			drop_object()
#
func _physics_process(_delta):
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
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

	move_and_slide()

func pick_object():
	var collider = interaction.get_collider()
	if collider != null and collider is RigidBody3D:
		picked_object = collider
	elif collider != null and collider is StaticBody3D and collider.has_method("pick_item"):
		picked_object = collider.pick_item()
		

func drop_object():
	if picked_object != null:
		picked_object = null

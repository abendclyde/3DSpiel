class_name Player

extends CharacterBody3D

@export var camera: Camera3D

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5
const MOUNSE_SENS: float = 0.001

var rotation_target_player : float
var rotation_target_head : float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	rotate_camera()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	rotate_player()

func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return

	# Listen for mouse movement and check if mouse is captured
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		set_rotation_target(event.relative)

func set_rotation_target(mouse_motion : Vector2) -> void:
	# Add player target to the mouse -x input
	rotation_target_player += -mouse_motion.x * MOUNSE_SENS
	# Add head target to the mouse -y input
	rotation_target_head += -mouse_motion.y * MOUNSE_SENS
	# clamo head rotation
	rotation_target_head = clamp(rotation_target_head, deg_to_rad(-90), deg_to_rad(90))

func rotate_player() -> void:
	quaternion = Quaternion(Vector3.UP, rotation_target_player)

func rotate_camera() -> void:
	camera.quaternion = Quaternion(Vector3.RIGHT, rotation_target_head)

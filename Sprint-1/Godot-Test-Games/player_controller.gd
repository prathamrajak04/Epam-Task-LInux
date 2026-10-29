class_name PlayerController
extends CharacterBody3D

## Movement parameters
@export_group("Movement")
@export var walk_speed: float = 3.8
@export var run_speed: float = 6.8
@export var acceleration: float = 14.0
@export var deceleration: float = 16.0
@export var rotation_speed: float = 12.0
@export var jump_velocity: float = 6.0

## Camera parameters
@export_group("Camera")
@export var mouse_sensitivity: float = 0.003
@export var min_pitch: float = -50.0 # degrees
@export var max_pitch: float = 25.0  # degrees

## Node references
@onready var visuals: Node3D = $Visuals
@onready var camera_pivot: Node3D = $CameraPivot
@onready var spring_arm: SpringArm3D = $CameraPivot/SpringArm3D
@onready var camera: Camera3D = $CameraPivot/SpringArm3D/Camera3D

# Modular limbs for procedural walking motion
@onready var leg_l: Node3D = $Visuals/LegLeft
@onready var leg_r: Node3D = $Visuals/LegRight
@onready var arm_l: Node3D = $Visuals/ArmLeft
@onready var arm_r: Node3D = $Visuals/ArmRight

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)
var walk_anim_phase: float = 0.0
var mouse_captured: bool = false

func _ready() -> void:
	if camera:
		camera.current = true
	# Start in visible mode; click game window to capture mouse
	capture_mouse(false)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			capture_mouse(true)
	
	if event.is_action_pressed("ui_cancel"):
		capture_mouse(false)
		
	if mouse_captured and event is InputEventMouseMotion:
		camera_pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		spring_arm.rotate_x(-event.relative.y * mouse_sensitivity)
		spring_arm.rotation.x = clamp(
			spring_arm.rotation.x,
			deg_to_rad(min_pitch),
			deg_to_rad(max_pitch)
		)

func capture_mouse(capture: bool) -> void:
	mouse_captured = capture
	if capture:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	# Movement input (WASD + Arrows)
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	# Direction relative to camera facing
	var cam_basis: Basis = camera_pivot.global_transform.basis
	var forward: Vector3 = -cam_basis.z
	forward.y = 0.0
	forward = forward.normalized()
	var right: Vector3 = cam_basis.x
	right.y = 0.0
	right = right.normalized()
	
	var move_dir: Vector3 = (forward * -input_dir.y + right * input_dir.x).normalized()
	
	var is_running: bool = Input.is_action_pressed("sprint")
	var target_speed: float = run_speed if is_running else walk_speed
	
	if move_dir.length_squared() > 0.001:
		velocity.x = move_toward(velocity.x, move_dir.x * target_speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, move_dir.z * target_speed, acceleration * delta)
		
		# Smoothly rotate visual mesh toward movement direction
		var target_angle: float = atan2(-move_dir.x, -move_dir.z)
		visuals.rotation.y = lerp_angle(visuals.rotation.y, target_angle, rotation_speed * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0.0, deceleration * delta)
	
	move_and_slide()
	
	_update_procedural_animation(delta, move_dir.length_squared() > 0.001)

func _update_procedural_animation(delta: float, is_moving: bool) -> void:
	var horizontal_speed: float = Vector2(velocity.x, velocity.z).length()
	
	if is_on_floor() and is_moving and horizontal_speed > 0.2:
		var anim_speed: float = 11.0 if Input.is_action_pressed("sprint") else 7.5
		walk_anim_phase += delta * anim_speed
		
		visuals.position.y = abs(sin(walk_anim_phase)) * 0.05
		
		var leg_angle: float = sin(walk_anim_phase) * 0.45
		if leg_l:
			leg_l.rotation.x = leg_angle
		if leg_r:
			leg_r.rotation.x = -leg_angle
			
		var arm_angle: float = sin(walk_anim_phase) * 0.35
		if arm_l:
			arm_l.rotation.x = -arm_angle
		if arm_r:
			arm_r.rotation.x = arm_angle
	else:
		visuals.position.y = lerp(visuals.position.y, 0.0, 10.0 * delta)
		if leg_l:
			leg_l.rotation.x = lerp_angle(leg_l.rotation.x, 0.0, 10.0 * delta)
		if leg_r:
			leg_r.rotation.x = lerp_angle(leg_r.rotation.x, 0.0, 10.0 * delta)
		if arm_l:
			arm_l.rotation.x = lerp_angle(arm_l.rotation.x, 0.0, 10.0 * delta)
		if arm_r:
			arm_r.rotation.x = lerp_angle(arm_r.rotation.x, 0.0, 10.0 * delta)

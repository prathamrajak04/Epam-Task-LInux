class_name LumiFollower
extends Node3D

@export var target: Node3D
@export var follow_speed: float = 5.2
@export var follow_offset: Vector3 = Vector3(-0.52, 1.12, -0.12)
@export var bob_amplitude: float = 0.08
@export var bob_frequency: float = 3.2
@export var wing_flutter_speed: float = 28.0

@onready var visual_root: Node3D = $Visuals
@onready var wing_l: Node3D = $Visuals/Wings/WingLeft
@onready var wing_r: Node3D = $Visuals/Wings/WingRight
@onready var omni_light: OmniLight3D = $OmniLight3D

var _anim_time: float = 0.0
var _is_cheering: bool = false
var _cheer_timer: float = 0.0

func _ready() -> void:
	if not target and get_parent():
		target = get_parent().get_node_or_null("Player")
	
	if target:
		var heading: float = _get_target_heading()
		var rotated_offset: Vector3 = follow_offset.rotated(Vector3.UP, heading)
		global_position = target.global_position + rotated_offset
		rotation.y = heading + deg_to_rad(125.0)

func _get_target_heading() -> float:
	if target:
		var visuals: Node3D = target.get_node_or_null("Visuals")
		if visuals:
			return visuals.global_rotation.y
		return target.global_rotation.y
	return 0.0

func cheer() -> void:
	_is_cheering = true
	_cheer_timer = 1.4
	if omni_light:
		omni_light.light_energy = 0.9

func _process(delta: float) -> void:
	_anim_time += delta
	
	if _is_cheering:
		_cheer_timer -= delta
		if visual_root:
			visual_root.rotation.y += delta * 14.0
		if _cheer_timer <= 0.0:
			_is_cheering = false
			if visual_root:
				visual_root.rotation.y = 0.0
	
	if not target and get_parent():
		target = get_parent().get_node_or_null("Player")
	
	if target:
		var heading: float = _get_target_heading()
		var rotated_offset: Vector3 = follow_offset.rotated(Vector3.UP, heading)
		var desired_pos: Vector3 = target.global_position + rotated_offset
		
		# Gentle hovering bob (happier bob when cheering)
		var freq = bob_frequency * (1.8 if _is_cheering else 1.0)
		var amp = bob_amplitude * (1.5 if _is_cheering else 1.0)
		desired_pos.y += sin(_anim_time * freq) * amp
		
		# Smooth follow
		global_position = global_position.lerp(desired_pos, follow_speed * delta)
		
		# Face toward the player & camera (showing cute face and wings)
		if not _is_cheering:
			var desired_yaw: float = heading + deg_to_rad(125.0)
			rotation.y = lerp_angle(rotation.y, desired_yaw, 6.0 * delta)
	
	# Rapid wing fluttering
	if wing_l and wing_r:
		var flutter = wing_flutter_speed * (1.8 if _is_cheering else 1.0)
		var wing_flap: float = sin(_anim_time * flutter) * 0.4
		wing_l.rotation.y = wing_flap
		wing_r.rotation.y = -wing_flap
	
	# Warm pulsing glow
	if omni_light and not _is_cheering:
		omni_light.light_energy = 0.42 + sin(_anim_time * 2.5) * 0.08

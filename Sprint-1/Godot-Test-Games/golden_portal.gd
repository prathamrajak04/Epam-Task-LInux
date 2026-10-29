class_name GoldenPortal
extends StaticBody3D

signal portal_entered

@export var is_unlocked: bool = false

@onready var portal_core: MeshInstance3D = $PortalCore
@onready var portal_light: OmniLight3D = $PortalLight
@onready var sparks: CPUParticles3D = $Sparks
@onready var trigger_area: Area3D = $TriggerArea

var _anim_time: float = 0.0

func _ready() -> void:
	if trigger_area:
		trigger_area.body_entered.connect(_on_trigger_body_entered)
	
	if is_unlocked:
		unlock_portal(false)
	else:
		lock_portal()

func _process(delta: float) -> void:
	_anim_time += delta
	if is_unlocked:
		if portal_light:
			portal_light.light_energy = 3.6 + sin(_anim_time * 4.0) * 0.5
	else:
		if portal_light:
			portal_light.light_energy = 1.2 + sin(_anim_time * 1.5) * 0.25

func lock_portal() -> void:
	is_unlocked = false
	if portal_light:
		portal_light.light_color = Color(1.0, 0.82, 0.55)
		portal_light.light_energy = 1.2
		portal_light.omni_range = 14.0
	if sparks:
		sparks.amount = 20
		sparks.initial_velocity_min = 0.2
		sparks.initial_velocity_max = 0.5

func unlock_portal(_play_burst: bool = true) -> void:
	is_unlocked = true
	if portal_light:
		portal_light.light_color = Color(1.0, 0.94, 0.75)
		portal_light.light_energy = 4.2
		portal_light.omni_range = 32.0
	if sparks:
		sparks.amount = 65
		sparks.initial_velocity_min = 0.5
		sparks.initial_velocity_max = 1.8

func _on_trigger_body_entered(body: Node3D) -> void:
	if not is_unlocked:
		return
	if body.is_in_group("player") or body.name == "Player":
		portal_entered.emit()
		var gm = get_tree().root.find_child("GameManager", true, false)
		if gm and gm.has_method("on_portal_reached"):
			gm.on_portal_reached()

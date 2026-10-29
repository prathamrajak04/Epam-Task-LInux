class_name InteractiveLantern
extends Node3D

signal lantern_awakened(lantern_index: int)

@export var lantern_index: int = 1
@export var is_awakened: bool = false
@export var prompt_text: String = "Press [E] to Awaken Shrine Lantern"

@onready var globe_mesh: MeshInstance3D = $Visuals/Globe
@onready var omni_light: OmniLight3D = $OmniLight3D
@onready var beam_mesh: MeshInstance3D = $Visuals/LightBeam
@onready var particles_dormant: CPUParticles3D = $ParticlesDormant
@onready var particles_awakening: CPUParticles3D = $ParticlesAwakening
@onready var area: Area3D = $InteractionArea

var _player_in_range: bool = false
var _anim_time: float = 0.0

func _ready() -> void:
	if area:
		area.body_entered.connect(_on_body_entered)
		area.body_exited.connect(_on_body_exited)
	
	if beam_mesh:
		beam_mesh.visible = is_awakened
	
	if is_awakened:
		_apply_awakened_visuals(false)
	else:
		_apply_dormant_visuals()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		_player_in_range = true
		if not is_awakened:
			var gm = get_tree().root.find_child("GameManager", true, false)
			if gm and gm.has_method("show_interaction_prompt"):
				gm.show_interaction_prompt(self, prompt_text)

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		_player_in_range = false
		var gm = get_tree().root.find_child("GameManager", true, false)
		if gm and gm.has_method("hide_interaction_prompt"):
			gm.hide_interaction_prompt(self)

func _process(delta: float) -> void:
	_anim_time += delta
	
	if not is_awakened:
		# Gentle breathing pulse for dormant lantern
		if omni_light:
			omni_light.light_energy = 0.8 + sin(_anim_time * 2.2) * 0.2
		
		# Check interaction input
		if _player_in_range and Input.is_action_just_pressed("interact"):
			awaken()
	else:
		# Radiant pulse for awakened lantern
		if omni_light:
			omni_light.light_energy = 2.8 + sin(_anim_time * 3.5) * 0.35
		if beam_mesh:
			beam_mesh.rotation.y += delta * 0.5

func awaken() -> void:
	if is_awakened:
		return
	is_awakened = true
	
	_apply_awakened_visuals(true)
	
	var gm = get_tree().root.find_child("GameManager", true, false)
	if gm:
		if gm.has_method("hide_interaction_prompt"):
			gm.hide_interaction_prompt(self)
		if gm.has_method("on_lantern_awakened"):
			gm.on_lantern_awakened(lantern_index, global_position)
	
	lantern_awakened.emit(lantern_index)

func _apply_dormant_visuals() -> void:
	if omni_light:
		omni_light.light_color = Color(1.0, 0.76, 0.38)
		omni_light.light_energy = 0.8
		omni_light.omni_range = 4.2
	if beam_mesh:
		beam_mesh.visible = false
	if particles_dormant:
		particles_dormant.emitting = true
	if particles_awakening:
		particles_awakening.emitting = false

func _apply_awakened_visuals(play_burst: bool) -> void:
	if omni_light:
		omni_light.light_color = Color(1.0, 0.90, 0.58)
		omni_light.light_energy = 3.2
		omni_light.omni_range = 8.5
	if beam_mesh:
		beam_mesh.visible = true
	if particles_dormant:
		particles_dormant.emitting = false
	if particles_awakening and play_burst:
		particles_awakening.restart()
		particles_awakening.emitting = true

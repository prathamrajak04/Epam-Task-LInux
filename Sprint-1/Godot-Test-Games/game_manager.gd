class_name GameManager
extends Node

@export var total_lanterns: int = 3
@export var initial_fog_density: float = 0.018

@export var world_environment: WorldEnvironment
@export var sun_light: DirectionalLight3D
@export var golden_portal: Node3D
@export var lumi: Node3D
@export var hud: CanvasLayer

var awakened_lanterns: int = 0
var is_portal_open: bool = false
var _active_env: Environment

func _ready() -> void:
	# Resolve references if not explicitly linked
	if not world_environment:
		world_environment = get_tree().root.find_child("WorldEnvironment", true, false)
	if not sun_light:
		sun_light = get_tree().root.find_child("DirectionalLight3D", true, false)
	if not golden_portal:
		golden_portal = get_tree().root.find_child("GoldenPortal", true, false)
	if not lumi:
		lumi = get_tree().root.find_child("Lumi", true, false)
	if not hud:
		hud = get_tree().root.find_child("GameHUD", true, false)
	
	if world_environment and world_environment.environment:
		# Duplicate environment to allow runtime tweening without polluting disk resource
		_active_env = world_environment.environment.duplicate()
		world_environment.environment = _active_env
		_active_env.fog_enabled = true
		_active_env.fog_density = initial_fog_density
	
	if sun_light:
		sun_light.light_energy = 0.74
	
	if hud and hud.has_method("update_lantern_progress"):
		hud.update_lantern_progress(0, total_lanterns)

func show_interaction_prompt(lantern: Object, prompt_text: String) -> void:
	if hud and hud.has_method("show_interact_prompt"):
		hud.show_interact_prompt(lantern, prompt_text)

func hide_interaction_prompt(lantern: Object) -> void:
	if hud and hud.has_method("hide_interact_prompt"):
		hud.hide_interact_prompt(lantern)

func on_lantern_awakened(_index: int, _pos: Vector3) -> void:
	awakened_lanterns += 1
	
	if hud and hud.has_method("update_lantern_progress"):
		hud.update_lantern_progress(awakened_lanterns, total_lanterns)
	
	if lumi and lumi.has_method("cheer"):
		lumi.cheer()
	
	if awakened_lanterns == 1:
		if hud and hud.has_method("show_banner"):
			hud.show_banner("✦ Shrine Lantern Awakened (1/3) — The morning mist begins to part... ✦", 4.0)
		_tween_fog_and_sun(0.013, 0.92)
	elif awakened_lanterns == 2:
		if hud and hud.has_method("show_banner"):
			hud.show_banner("✦ Shrine Lantern Awakened (2/3) — Golden sunlight warms the forest! ✦", 4.0)
		_tween_fog_and_sun(0.008, 1.05)
	elif awakened_lanterns >= total_lanterns:
		is_portal_open = true
		if hud and hud.has_method("show_banner"):
			hud.show_banner("✦ All Shrine Lanterns Awakened! (3/3) — The Golden Portal has Opened! ✦", 5.0)
		_tween_fog_and_sun(0.0035, 1.18)
		
		if golden_portal and golden_portal.has_method("unlock_portal"):
			golden_portal.unlock_portal(true)

func on_portal_reached() -> void:
	if is_portal_open:
		if hud and hud.has_method("show_victory"):
			hud.show_victory()
		if lumi and lumi.has_method("cheer"):
			lumi.cheer()

func _tween_fog_and_sun(target_fog: float, target_sun: float) -> void:
	var tween = create_tween().set_parallel(true)
	if _active_env:
		tween.tween_property(_active_env, "fog_density", target_fog, 3.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	if sun_light:
		tween.tween_property(sun_light, "light_energy", target_sun, 3.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

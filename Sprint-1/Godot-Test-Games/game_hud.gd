class_name GameHUD
extends CanvasLayer

signal interact_pressed

@onready var objective_label: Label = $SafeContainer/TopBar/ObjectiveCard/VBox/ObjectiveLabel
@onready var progress_dots: Label = $SafeContainer/TopBar/ObjectiveCard/VBox/ProgressDots
@onready var message_banner: PanelContainer = $SafeContainer/MessageBanner
@onready var message_label: Label = $SafeContainer/MessageBanner/MessageLabel
@onready var interact_btn: Button = $SafeContainer/InteractButton
@onready var victory_modal: Control = $VictoryModal

var _current_target_lantern = null
var _banner_timer: float = 0.0

func _ready() -> void:
	if message_banner:
		message_banner.visible = false
	if interact_btn:
		interact_btn.visible = false
		interact_btn.pressed.connect(_on_interact_button_pressed)
	if victory_modal:
		victory_modal.visible = false
		var continue_btn = victory_modal.find_child("ContinueButton", true, false)
		if continue_btn and continue_btn is Button:
			continue_btn.pressed.connect(_on_continue_button_pressed)
		var restart_btn = victory_modal.find_child("RestartButton", true, false)
		if restart_btn and restart_btn is Button:
			restart_btn.pressed.connect(_on_restart_button_pressed)

func _process(delta: float) -> void:
	if _banner_timer > 0.0:
		_banner_timer -= delta
		if _banner_timer <= 0.0 and message_banner:
			var tween = create_tween()
			tween.tween_property(message_banner, "modulate:a", 0.0, 0.4)
			tween.tween_callback(func(): message_banner.visible = false)

func update_lantern_progress(current: int, total: int) -> void:
	if objective_label:
		if current < total:
			objective_label.text = "Awaken the Shrine Lanterns (%d / %d)" % [current, total]
		else:
			objective_label.text = "✦ The Golden Portal is Open! ✦"
	
	if progress_dots:
		var dots = ""
		for i in range(total):
			if i < current:
				dots += "✦ "
			else:
				dots += "✧ "
		progress_dots.text = dots.strip_edges()

func show_banner(text: String, duration: float = 3.5) -> void:
	if not message_banner or not message_label:
		return
	message_label.text = text
	message_banner.visible = true
	message_banner.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(message_banner, "modulate:a", 1.0, 0.3)
	_banner_timer = duration

func show_interact_prompt(lantern: Object, prompt_text: String) -> void:
	_current_target_lantern = lantern
	if interact_btn:
		interact_btn.text = "✦ " + prompt_text
		interact_btn.visible = true
		interact_btn.modulate.a = 0.0
		var tween = create_tween()
		tween.tween_property(interact_btn, "modulate:a", 1.0, 0.2)

func hide_interact_prompt(lantern: Object) -> void:
	if _current_target_lantern == lantern:
		_current_target_lantern = null
		if interact_btn:
			var tween = create_tween()
			tween.tween_property(interact_btn, "modulate:a", 0.0, 0.2)
			tween.tween_callback(func(): interact_btn.visible = false)

func show_victory() -> void:
	if victory_modal:
		victory_modal.visible = true
		victory_modal.modulate.a = 0.0
		var tween = create_tween()
		tween.tween_property(victory_modal, "modulate:a", 1.0, 0.6)

func _on_interact_button_pressed() -> void:
	if _current_target_lantern and _current_target_lantern.has_method("awaken"):
		_current_target_lantern.awaken()
	interact_pressed.emit()

func _on_continue_button_pressed() -> void:
	if victory_modal:
		var tween = create_tween()
		tween.tween_property(victory_modal, "modulate:a", 0.0, 0.3)
		tween.tween_callback(func(): victory_modal.visible = false)

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

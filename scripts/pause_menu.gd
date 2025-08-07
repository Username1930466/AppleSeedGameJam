extends Node2D

var menu_scene = "res://scenes/Menu.tscn"
var settings = false

func _ready() -> void:
	$ScreenshakeToggle.button_pressed = Global.screenshake
	$BloodToggle.button_pressed = Global.blood

func _on_resume_button_pressed() -> void:
	unpause()

func unpause():
	settings = false
	$ScreenshakeToggle.visible = false
	$BloodToggle.visible = false
	Global.paused = false
	visible = false
	get_tree().paused = false

func _on_menu_button_pressed() -> void:
	$"../UpgradeMenu".upgrade_menu = false
	unpause()
	get_tree().change_scene_to_file(menu_scene)

func _on_settings_button_pressed() -> void:
	if settings:
		settings = false
		$ScreenshakeToggle.visible = false
		$BloodToggle.visible = false
	else:
		settings = true
		$ScreenshakeToggle.visible = true
		$BloodToggle.visible = true

func _on_screenshake_toggle_pressed() -> void:
	Global.screenshake = $ScreenshakeToggle.button_pressed

func _on_blood_toggle_pressed() -> void:
	Global.blood = $BloodToggle.button_pressed

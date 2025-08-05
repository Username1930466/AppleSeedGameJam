extends Node2D

var game_scene = preload("res://scenes/Game.tscn")
var settings = false

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	if settings:
		settings = false
		$ScreenshakeToggle.visible = false
	else:
		settings = true
		$ScreenshakeToggle.visible = true

func _on_screenshake_toggle_pressed() -> void:
	Global.screenshake = $ScreenshakeToggle.button_pressed

extends Node2D

var game_scene = preload("res://scenes/Game.tscn")
var settings = false
var selected_dino = 0
var empty_upgrades = {"Multishot": 0, "Double Shot": 0, "Ricohet": 0, "Pierce": 0, "Faster Reload": 0}

func _ready() -> void:
	$ScreenshakeToggle.button_pressed = Global.screenshake
	$BloodToggle.button_pressed = Global.blood


func _process(delta):
		$Title/Label/AnimationPlayer.play("title_bump")


func _on_play_button_pressed() -> void:
	Global.upgrades = empty_upgrades
	Global.current_dino = Global.available_dinos[selected_dino]
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

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

func _on_next_dino_button_pressed() -> void:
	selected_dino += 1
	if selected_dino >= Global.available_dinos.size():
		selected_dino = 0
	display_selected()

func _on_prev_dino_button_pressed() -> void:
	selected_dino -= 1
	if selected_dino <= -1:
		selected_dino = Global.available_dinos.size() - 1
	display_selected()

func display_selected():
	var selected_stats = Global.available_dinos[selected_dino]
	$DinoSprite.play(selected_stats.idle_anim)
	$DinoNameLabel.text = selected_stats.name

func _on_blood_toggle_pressed() -> void:
	Global.blood = $BloodToggle.button_pressed

extends Node2D

func _ready() -> void:
	Global.game = self
	Global.player = $Player
	Global.cam = $Player/Camera2D
	$UI/HealthBar.max_value = $Player.max_health
	$UI/HealthBar.value = $Player.health

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if Global.paused:
			$UI/PauseMenu.unpause()
		else:
			Global.paused = true
			$UI/PauseMenu.visible = true
			$UI/PauseMenu.position = $Player.position
			get_tree().paused = true
	$UI.position = $Player/Camera2D.global_position
	$UI/HealthBar.value = $Player.health
	$UI/AmmoBar.value = (float($Player.get_node("Gun").ammo) / Global.current_dino.gun.capacity) * 100
	$UI/AmmoLabel.text = str($Player.get_node("Gun").ammo)

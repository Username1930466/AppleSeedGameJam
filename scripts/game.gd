extends Node2D

func _ready() -> void:
	Global.game = self
	Global.player = $Player
	Global.cam = $Camera2D
	$UI/HealthBar.max_value = $Player.max_health
	$UI/HealthBar.value = $Player.health

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if Global.paused:
			$UI/PauseMenu.unpause()
		else:
			Global.paused = true
			$UI/PauseMenu.visible = true
			get_tree().paused = true
	
	$UI.position = $Camera2D.global_position
	$UI/HealthBar.value = $Player.health
	var gun = $Player.get_node("Gun")
	if gun.reloading:
		$UI/AmmoBar.fill_mode = 4
		$UI/AmmoLabel.text = ". . ."
		$UI/AmmoBar.value = (gun.reload_cooldown / gun.reload_time) * 100
	else:
		$UI/AmmoBar.fill_mode = 5
		$UI/AmmoLabel.text = str(gun.ammo)
		$UI/AmmoBar.value = (float(gun.ammo) / Global.current_dino.gun.capacity) * 100
	
	$UI/MeleeCooldownBar.value = ($Player.get_node("Melee").cooldown / Global.current_dino.melee_attack.cooldown) * 100

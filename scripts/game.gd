extends Node2D

func _ready() -> void:
	Global.game = self
	Global.cam = $Player/Camera2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if Global.paused:
			$PauseMenu.unpause()
		else:
			Global.paused = true
			$PauseMenu.visible = true
			$PauseMenu.position = $Player.position
			get_tree().paused = true

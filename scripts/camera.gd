extends Camera2D

func screenshake(intensity: float, shake_time: float, shakes: int):
	for i in shakes:
		position_smoothing_enabled = false
		position += Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		await get_tree().create_timer(shake_time).timeout
		position_smoothing_enabled = true
		position = Vector2(0, 0)
		await get_tree().create_timer(shake_time).timeout

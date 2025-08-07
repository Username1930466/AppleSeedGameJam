extends Camera2D

func _process(delta: float) -> void:
	global_position = global_position.lerp(Global.player.global_position, delta * 3)

func screenshake(intensity: float, shake_time: float, shakes: int):
	for i in shakes:
		position += Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		await get_tree().create_timer(shake_time).timeout

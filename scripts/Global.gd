extends Node

var game: Node2D
var cam: Camera2D

func screenshake(intensity: float, shake_time: float, shakes: int):
	for i in 5:
		cam.position_smoothing_enabled = false
		cam.position += Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		await get_tree().create_timer(shake_time).timeout
		cam.position_smoothing_enabled = true
		cam.position = Vector2(0, 0)
		await get_tree().create_timer(shake_time).timeout

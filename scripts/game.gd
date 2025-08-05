extends Node2D

func _ready() -> void:
	Global.game = self
	Global.cam = $Player/Camera2D

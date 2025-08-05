extends RigidBody2D

var dir: Vector2

func _ready() -> void:
	rotation = dir.angle()
	linear_velocity = dir * 1000

func _process(delta: float) -> void:
	linear_velocity += dir

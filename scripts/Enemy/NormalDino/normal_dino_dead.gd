extends State
class_name NormalDinoDead

@onready var collision = $"../../CollisionShape2D"


@export var enemy : CharacterBody2D

func Enter():
	enemy.velocity = Vector2()
	collision.disabled = true

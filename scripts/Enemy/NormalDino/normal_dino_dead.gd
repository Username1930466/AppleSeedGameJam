extends State
class_name NormalDinoDead

@onready var collision = $"../../HitBox"


@export var enemy : CharacterBody2D

func Enter():
	enemy.velocity = Vector2()
	collision.disabled = true

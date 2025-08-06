extends State
class_name NormalDinoDead

@export var enemy : CharacterBody2D

func Enter():
	enemy.velocity = Vector2()

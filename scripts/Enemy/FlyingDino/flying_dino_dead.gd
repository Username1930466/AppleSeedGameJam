extends State
class_name FlyingDinoDead

@export var enemy : CharacterBody2D

func Enter():
	enemy.velocity = Vector2()

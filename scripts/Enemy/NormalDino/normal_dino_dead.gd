extends State
class_name NormalDinoDead

@onready var collision = $"../../HitBox"

@onready var hurtbox = $"../../HurtBoxArea/Hurtbox"
@export var enemy : CharacterBody2D

func Enter():
	enemy.velocity = Vector2()
	collision.disabled = true
	hurtbox.disabled = true
	enemy.enemy_dead.emit()

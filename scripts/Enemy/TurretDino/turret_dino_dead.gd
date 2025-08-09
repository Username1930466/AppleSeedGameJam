extends State
class_name TurretDinoDead

var exp_scene = preload("res://scenes/exp.tscn")
var deathshots = 600
var exp = 10


var bullet = preload("res://scenes/Enemies/Projectile/flying_dino_projectile.tscn")
@onready var collision = $"../../CollisionShape2D"


@export var enemy : CharacterBody2D

func Enter():
	enemy.velocity = Vector2.ZERO

func Physics_Update(delta):
	collision.disabled = true
	deathshots -= 5
	if deathshots % 50 == 0:
		create_bullet(Vector2(randf_range(-1,1),randf_range(-1,1)))
	if deathshots <= 0:
		spawn_exp()
		enemy.queue_free()

func create_bullet(dir):
	var new_bullet = bullet.instantiate()
	new_bullet.dir = dir
	new_bullet.global_position = enemy.global_position
	Global.game.add_child(new_bullet)

func spawn_exp():
	for i in exp:
		var exp = exp_scene.instantiate()
		exp.position = enemy.global_position + Vector2(randf_range(-128, 128), randf_range(-128, 128))
		Global.game.add_child(exp)

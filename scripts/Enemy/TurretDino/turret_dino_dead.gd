extends State
class_name TurretDinoDead


var deathshots = 600


var bullet = preload("res://scenes/Enemies/Projectile/flying_dino_projectile.tscn")
@export var enemy : CharacterBody2D


func Enter():
	enemy.velocity = Vector2.ZERO


func Physics_Update(delta):
	deathshots -= 5
	if deathshots % 50 == 0:
		create_bullet(Vector2(randf_range(-1,1),randf_range(-1,1)))
	if deathshots <= 0:
		enemy.queue_free()

func create_bullet(dir):
	var new_bullet = bullet.instantiate()
	new_bullet.dir = dir
	new_bullet.global_position = enemy.global_position
	Global.game.add_child(new_bullet)

extends State
class_name TurretDinoShoot



var cooldown = 200.0
var current_cooldown = cooldown
var bullet = preload("res://scenes/Enemies/Projectile/flying_dino_projectile.tscn")

@export var enemy : CharacterBody2D
var player : CharacterBody2D


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	enemy.velocity = Vector2.ZERO

func Physics_Update(delta):
	var distance = player.global_position - enemy.global_position
	current_cooldown -= 7
	if current_cooldown <= 0:
		current_cooldown = cooldown
		create_bullet(distance.normalized())


func create_bullet(dir):
	var new_bullet = bullet.instantiate()
	new_bullet.dir = dir
	new_bullet.global_position = enemy.global_position
	Global.game.add_child(new_bullet)

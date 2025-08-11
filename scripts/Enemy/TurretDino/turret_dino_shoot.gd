extends State
class_name TurretDinoShoot



var cooldown = 200.0
var current_cooldown = cooldown
var bullet = preload("res://scenes/Enemies/Projectile/flying_dino_projectile.tscn")

@export var enemy : CharacterBody2D
var player : CharacterBody2D


@onready var animation =  $"../../AnimatedSprite2D"



func Enter():
	player = get_tree().get_first_node_in_group("Player")
	set_animation()
	animation.play("idle")
	enemy.velocity = Vector2.ZERO


func Physics_Update(delta):
	var distance = player.global_position - enemy.global_position
	current_cooldown -= 7
	if current_cooldown <= 0:
		current_cooldown = cooldown
		create_bullet(distance.normalized())
	if enemy.health <= 0:
		Transitioned.emit(self,"TurretDinoDead")
	set_animation()

func create_bullet(dir):
	var new_bullet = bullet.instantiate()
	new_bullet.dir = dir
	new_bullet.global_position = enemy.global_position
	Global.game.add_child(new_bullet)

func set_animation():
	if enemy.position.x > player.position.x:
		animation.flip_h = false
	else:
		animation.flip_h = true

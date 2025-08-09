extends State
class_name FlyingDinoCharge

@export var enemy : FlyingDinoEnemy

var time := 0.0
var move_speed := 1.0
var radius := 500.0
var cooldown := 600.0
var current_cooldown = cooldown

var bullet = preload("res://scenes/Enemies/Projectile/flying_dino_projectile.tscn")

@onready var sprite = $"../../AnimatedSprite2D"
var player : CharacterBody2D



func Enter():
	player = get_tree().get_first_node_in_group("Player")



func Update(delta):
	if enemy.health <= 0 :
		Transitioned.emit(self,"FlyingDinoDead")


func Physics_Update(delta):
	time += fmod(delta,PI * 2)
	var distance = player.global_position - enemy.global_position
	sprite.look_at(player.global_position)
	enemy.global_position = Vector2(
		sin(time * move_speed) * radius,
		cos(time * move_speed) * radius
		) + player.global_position
	current_cooldown -= 5
	if current_cooldown <= 0:
		create_bullet(distance.normalized())
		current_cooldown = cooldown

func create_bullet(dir):
	var new_bullet = bullet.instantiate()
	new_bullet.dir = dir
	new_bullet.global_position = enemy.global_position
	Global.game.add_child(new_bullet)

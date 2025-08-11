extends State
class_name BossDinoLaser

@export var enemy : BossDinoEnemy
var player : CharacterBody2D


@onready var laser_line = $"../../SpriteZone/Line2D"
var bullet = preload("res://scenes/Enemies/Projectile/flying_dino_projectile.tscn")


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	charge_beam()


func Physics_Update(delta):
	if enemy.health <= 0:
		Transitioned.emit(self,"BossDinoDead")


func charge_beam():
	laser_line.visible = true
	var distance = player.global_position - laser_line.global_position
	laser_line.points[1] = distance
	laser_line.points[2] = laser_line.points[1] + (laser_line.points[1] - laser_line.points[0]) * 100
	var new_distance = laser_line.points[2] - laser_line.points[1]
	fire_bullets(new_distance.normalized())

func fire_bullets(dir):
	await get_tree().create_timer(0.75).timeout
	laser_line.visible = false
	for i in 20:
		await get_tree().create_timer(0.1).timeout
		var new_bullet = bullet.instantiate()
		new_bullet.dir = dir
		new_bullet.global_position = enemy.global_position  + laser_line.points[0]
		new_bullet.bullet_speed = 2000
		Global.game.add_child(new_bullet)
	Transitioned.emit(self,"BossDinoIdle")

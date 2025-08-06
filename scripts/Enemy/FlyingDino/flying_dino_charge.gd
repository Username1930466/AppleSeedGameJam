extends State
class_name FlyingDinoCharge

@export var enemy : FlyingDinoEnemy


var move_speed := 40.0

var player : CharacterBody2D


func Enter():
	player = get_tree().get_first_node_in_group("Player")


func Update(delta):
	if enemy.health <= 0 :
		Transitioned.emit(self,"FlyingDinoDead")


func Physics_Update(delta):
	var distance = player.global_position - enemy.global_position
	enemy.velocity = distance.normalized() * move_speed * (enemy.new_speed * 1.33)

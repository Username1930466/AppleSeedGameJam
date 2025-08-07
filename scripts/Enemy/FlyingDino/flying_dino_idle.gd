extends State
class_name FlyingDinoIdle

@export var enemy : FlyingDinoEnemy
var player : CharacterBody2D


var radius := 500
var move_speed := 200.0



func Enter():
	player = get_tree().get_first_node_in_group("Player")


func Update(_delta : float):
	if enemy.health <= 0 :
		Transitioned.emit(self,"FlyingDinoDead")

func Physics_Update(delta : float):
	var distance = player.global_position - enemy.global_position
	
	if distance.length() > radius:
		enemy.velocity = distance.normalized() * move_speed
	else:
		Transitioned.emit(self,"FlyingDinoPreparing")

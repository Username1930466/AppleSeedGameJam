extends State
class_name TurretDinoIdle


var move_speed := 200.0
var move_direction : Vector2
var wander_time : float 


@export var enemy : CharacterBody2D
var player : CharacterBody2D


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	

func Physics_Update(delta):
	var distance = player.global_position - enemy.global_position
	
	if distance.length() > 400 :
		enemy.velocity = distance.normalized() * move_speed
	else:
		Transitioned.emit(self,"TurretDinoShoot")

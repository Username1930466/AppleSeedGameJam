extends State
class_name NormalDinoCharge

var move_speed := 200.0


@export var enemy : CharacterBody2D
var player : CharacterBody2D



func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta: float):
	var distance = player.global_position - enemy.global_position
	enemy.velocity = distance.normalized() * move_speed
		
	if enemy.health <= 0:
		Transitioned.emit(self,"NormalDinoDead")

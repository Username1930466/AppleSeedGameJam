extends State
class_name BossDinoIdle


@export var enemy : BossDinoEnemy

var cooldown := 600.0
var current_cooldown := cooldown

func Physics_Update(delta):
	cooldown -= 5
	if cooldown <= 0:
		current_cooldown = cooldown
		Transitioned.emit(self,"BossDinoLaser")
	if enemy.health <= 0:
		Transitioned.emit(self,"BossDinoDead")

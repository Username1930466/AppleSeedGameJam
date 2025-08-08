extends State
class_name FlyingDinoPreparing


@export var enemy : FlyingDinoEnemy

var time := 0.0
var move_speed := 400.0
var radius := 500.0
var player : CharacterBody2D
var timer : Timer


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	create_timer()


func Update(delta):
	pass


func Physics_Update(delta):
	var distance = (player.global_position + Vector2(0,radius)) - enemy.global_position
	enemy.velocity = distance.normalized() * move_speed
	if enemy.health <= 0:
		Transitioned.emit(self,"FlyingDinoDead")
	if is_equal_approx(enemy.global_position.y, (player.global_position.y + radius)):
		Transitioned.emit(self,"FlyingDinoCharge")
	await timer.timeout
	Transitioned.emit(self,"FlyingDinoCharge")

func create_timer():
	timer = Timer.new()
	timer.wait_time = 10.0
	timer.autostart = true
	add_child(timer)

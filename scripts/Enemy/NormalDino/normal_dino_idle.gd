extends State
class_name NormalDinoIdle

@export var enemy : CharacterBody2D
@export var move_speed := 50.0

var move_direction : Vector2
var wander_time : float 
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update(delta : float):
	if wander_time >0:
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(_delta:float):
	var distance = player.global_position - enemy.global_position
	if distance.length() < 400:
		Transitioned.emit(self,"NormalDinoCharge")
	else:
		enemy.velocity = move_direction * move_speed
	if enemy.health <= 0:
		Transitioned.emit(self,"NormalDinoDead")

func randomize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)

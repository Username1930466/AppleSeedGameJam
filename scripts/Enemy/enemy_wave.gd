extends Node


var spawn_radius := 2000
@onready var timer = $Timer

@export var enemy_list : Dictionary[String,PackedScene]
var player : CharacterBody2D

func _ready():
	pass
	
	


func spawn_enemies():
	var enemy_keys = enemy_list.keys()
	var size = randi() % enemy_list.size()
	var next_enemy = enemy_keys[size]
	player = get_tree().get_first_node_in_group("Player")
	var new_enemy = enemy_list[next_enemy].instantiate()
	new_enemy.global_position = player.global_position + Vector2(
		cos(randf_range(0,2 * PI)) * spawn_radius,
		sin(randf_range(0,2 * PI)) * spawn_radius)
	add_child(new_enemy)



func _on_timer_timeout():
	spawn_enemies()
	timer.start()

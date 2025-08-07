extends Node


var spawn_radius := 2000
"res://scenes/Enemies/normal_dino.tscn"

@export var enemy_list : Dictionary[String,PackedScene]
var player : CharacterBody2D

func ready():
	pass
func _input(event):
	if event.is_action_pressed("create_enemy"):
		spawn_enemies()

func spawn_enemies():
	player = get_tree().get_first_node_in_group("Player")
	var new_enemy = enemy_list["NormalDino"].instantiate()
	new_enemy.global_position = player.global_position + Vector2(0,randf_range(0,500))
	add_child(new_enemy)

extends Node


var spawn_radius := 500


var waves_list : Array
var current_wave_number := 0
var current_wave : Wave
var number_of_enemies : int


@onready var timer = $Timer



var player : CharacterBody2D



func _ready():
	prepare_enemy_list()
	load_wave("res://resources/waves/outside/" + waves_list[current_wave_number])
	current_wave_number += 1

func spawn_enemies():
	var enemy_keys = current_wave.enemy_list.keys()
	print(enemy_keys)
	var enemy_number = randi() % current_wave.enemy_list.size()
	var next_enemy = enemy_keys[enemy_number]
	player = get_tree().get_first_node_in_group("Player")
	var new_enemy = current_wave.enemy_list[next_enemy].instantiate()
	new_enemy.global_position = player.global_position + Vector2(
		cos(randf_range(0,2 * PI)) * spawn_radius,
		sin(randf_range(0,2 * PI)) * spawn_radius)
	add_child(new_enemy)


func prepare_enemy_list():
	var dir = DirAccess.open("res://resources/waves/outside/")
	dir.list_dir_begin()
	var new_file = dir.get_next()
	while new_file != "":
		waves_list.append(new_file)
		new_file = dir.get_next()


func load_wave(new_wave):
	current_wave = load(new_wave)




func _on_timer_timeout():
	spawn_enemies()
	timer.start()

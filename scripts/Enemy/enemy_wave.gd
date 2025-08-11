extends Node


var spawn_radius := 1500


var waves_list : Array
var show_text : bool
var stop_wave = false
var current_wave_number := 0
var current_wave : Wave


var current_enemy_number : int

@onready var timer = $NextEnemy
@onready var next_wave = $NextWave


var player : CharacterBody2D


signal start_wave




func _ready():
	
	player = get_tree().get_first_node_in_group("Player")
	prepare_enemy_list()
	load_wave("res://resources/waves/outside/" + waves_list[current_wave_number])
	current_enemy_number = current_wave.number_of_enemies


func _input(event):
	if event.is_action_pressed("create_enemy"):
		start_wave.emit()



func _physics_process(delta):
	current_wave_state()


func spawn_enemies():
	var enemy_keys = current_wave.enemy_list.keys()
	var enemy_number = randi() % current_wave.enemy_list.size()
	var next_enemy = enemy_keys[enemy_number]
	player = get_tree().get_first_node_in_group("Player")
	var new_enemy = current_wave.enemy_list[next_enemy].instantiate()
	new_enemy.global_position = player.global_position + Vector2(
		cos(randf_range(0,2 * PI)) * spawn_radius,
		sin(randf_range(0,2 * PI)) * spawn_radius)
	new_enemy.connect("enemy_dead",update_enemy_number)
	add_child(new_enemy)
	current_wave.number_of_enemies -= 1


func prepare_enemy_list():
	var dir = DirAccess.open("res://resources/waves/outside/")
	dir.list_dir_begin()
	var new_file = dir.get_next()
	while new_file != "":
		waves_list.append(new_file)
		new_file = dir.get_next()


func load_wave(new_wave):
	current_wave = load(new_wave)


func current_wave_state():
	if current_enemy_number == 0 && (current_wave_number % 3) != 0 :
		if current_wave.number_of_enemies == 0:
			$"../UI/WaveWon".visible = true
			next_wave.start()
			current_wave.number_of_enemies = -1
			player.health = player.max_health
		$"../UI/WaveWon".text = ("WAVE WON!\rNew wave starts in : " + str((int(ceil(next_wave.time_left)))))
	if current_enemy_number == 0 && (current_wave_number % 3) == 0:
		if current_wave.number_of_enemies == 0:
			$"../UI/WaveWon".visible = true
			current_wave.number_of_enemies = -1
			$"../UI/WaveWon".text = ("WAVE WON! You may rest for now \r or \r Press K to continue. " )
			await start_wave
			next_wave.wait_time -= 1.0 
			if next_wave.wait_time <= 1.0:
				next_wave.wait_time = 1.0
			$"../UI/WaveWon".visible = false
			await get_tree().create_timer(1.5)
			start_new_wave()
			player.health = player.max_health

func update_enemy_number():
	current_enemy_number -= 1




func _on_timer_timeout():
	if current_wave.number_of_enemies > 0:
		spawn_enemies()
		timer.start()




func _on_next_wave_timeout():
	start_new_wave()
	$"../UI/WaveWon".visible = false


func start_new_wave():

	if current_wave_number < waves_list.size():
		if current_wave_number != 15:
			load_wave("res://resources/waves/outside/" + waves_list[current_wave_number + 1])
			current_enemy_number = current_wave.number_of_enemies
		else:
			load_wave("res://resources/waves/outside/boss_wave.tres")
			current_enemy_number = current_wave.number_of_enemies
	else:
		load_wave("res://resources/waves/outside/" + waves_list[8])
	current_wave_number += 1

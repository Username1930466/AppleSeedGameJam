extends StaticBody2D


@export var enemy_list : Dictionary[String,PackedScene]
@onready var countdown = $Countdown
var max_countdown := 15.0


func _ready():
	countdown.wait_time = randf_range(max_countdown - 5, max_countdown)


func _input(event):
	if event.is_action_pressed("create_enemy"):
		spawn_enemies()




func spawn_enemies():
	var enemy_keys = enemy_list.keys()
	var size = randi() % enemy_list.size()
	var next_enemy = enemy_keys[size]
	var new_enemy = enemy_list[next_enemy].instantiate()
	add_child(new_enemy)
	


func _on_countdown_timeout():
	spawn_enemies()

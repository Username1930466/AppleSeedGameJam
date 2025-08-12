extends State
class_name BossDinoStart

@export var enemy : BossDinoEnemy
var player : CharacterBody2D

@onready var line = $"../../SpriteZone/Line2D2"

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	player.play_boss_music()

func Physics_Update(delta):
	enemy.global_position = Vector2(-4096,-5368)
	var distance = player.global_position - line.global_position
	line.points[1] = distance
	if distance.length() >= 600:
		line.visible = true
	else:
		begin_fight()

func begin_fight():
	line.visible = false
	$"../../AnimationPlayer".play("boss_intro")
	await $"../../AnimationPlayer".animation_finished
	$"../../StompPlayer".playing = true
	line.queue_free()
	Transitioned.emit(self,"BossDinoIdle")

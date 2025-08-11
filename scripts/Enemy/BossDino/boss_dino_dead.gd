extends State
class_name BossDinoDead

var exp_scene = preload("res://scenes/exp.tscn")
var exp = 300

@export var enemy : BossDinoEnemy


func Enter():
	$"../../SpriteZone/BossSprite".flip_v = true
	await get_tree().create_timer(5).timeout
	spawn_exp()


func spawn_exp():
	for i in exp:
		var exp = exp_scene.instantiate()
		exp.position = enemy.global_position + Vector2(randf_range(-128, 128), randf_range(-128, 128))
		Global.game.add_child(exp)

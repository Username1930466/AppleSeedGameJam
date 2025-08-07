extends CharacterBody2D
class_name NormalDinoEnemy

var exp_scene = preload("res://scenes/exp.tscn")

var health = 100
var exp = 5

func _physics_process(delta):
	move_and_slide()
	set_animation()


func set_animation():
	if health > 0 :
		if velocity.length() > 0:
			$AnimatedSprite2D.play("follow")
		
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_v = true
		await get_tree().create_timer(5).timeout
		spawn_exp()
		queue_free()

func spawn_exp():
	for i in exp:
		var exp = exp_scene.instantiate()
		exp.position = global_position + Vector2(randf_range(-128, 128), randf_range(-128, 128))
		Global.game.add_child(exp)

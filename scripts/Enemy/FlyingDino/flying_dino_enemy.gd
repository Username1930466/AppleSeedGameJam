extends CharacterBody2D
class_name FlyingDinoEnemy

var exp_scene = preload("res://scenes/exp.tscn")

var new_speed = randf_range(0.5,1)
var health = 25
var exp = 10

@onready var shader = $AnimationPlayer


signal enemy_dead



func _ready():
	pass

func _physics_process(delta):
	move_and_slide()
	set_animation()

func set_animation():
	if health > 0 :
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
	
func take_damage(damage):
	health -= damage
	shader.play("enemy_hit")

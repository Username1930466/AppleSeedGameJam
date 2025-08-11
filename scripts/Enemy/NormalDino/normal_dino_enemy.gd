extends CharacterBody2D
class_name NormalDinoEnemy

var exp_scene = preload("res://scenes/exp.tscn")

var health = 60
var damage = 10
var exp = 5

var player : CharacterBody2D

@onready var hurtbox = $HurtBoxArea/Hurtbox
@onready var shader = $AnimationPlayer


signal enemy_dead


func _ready():
	player = get_tree().get_first_node_in_group("Player")

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

func take_damage(damage):
	health -= damage
	shader.play("enemy_hit")


func _on_area_2d_body_entered(player):
	if player:
		give_damage(damage)

func give_damage(damage):
	hurtbox.set_deferred("disabled", true)
	player.take_damage(damage)
	await get_tree().create_timer(1.0).timeout
	hurtbox.set_deferred("disabled",false)
	
	var current_body = $HurtBoxArea.get_overlapping_bodies()
	if player in current_body && hurtbox.disabled:
		give_damage(damage)
	else:
		return

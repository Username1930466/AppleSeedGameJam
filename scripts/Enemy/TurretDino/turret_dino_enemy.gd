extends CharacterBody2D
class_name TurretDinoEnemy

var new_speed = randf_range(0.5,1)
var health = 80
var exp = 10


signal enemy_dead



@onready var shader = $AnimationPlayer


func _ready():
	pass

func _physics_process(delta):
	move_and_slide()
	set_animation()

func set_animation():
	if health > 0 :
		pass
	else:
		$AnimatedSprite2D.flip_v = true

func take_damage(damage):
	health -= damage
	shader.play("enemy_hit")

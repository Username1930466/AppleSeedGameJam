extends CharacterBody2D
class_name TurretDinoEnemy


var new_speed = randf_range(0.5,1)
var health = 50

func _ready():
	pass

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

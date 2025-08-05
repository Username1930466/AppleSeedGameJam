extends CharacterBody2D
class_name NormalDinoEnemy


var health = 50

func _ready():
	pass

func _physics_process(delta):
	move_and_slide()
	set_animation()
	if health <= 0:
		$AnimatedSprite2D.flip_v = true

func set_animation():
	if velocity.length() >0:
		$AnimatedSprite2D.play("follow")
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func take_damage(amount):
	print("Damage :" + amount)

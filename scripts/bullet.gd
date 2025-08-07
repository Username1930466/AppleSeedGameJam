extends RigidBody2D

var brick_hit = preload("res://sounds/bullet_brick.mp3")
var flesh_hit = preload("res://sounds/flesh_hit.mp3")

var damage: int
var dir: Vector2

func _ready() -> void:
	$Area2D.area_entered.connect(_on_area_2d_body_entered)
	rotation = dir.angle()
	linear_velocity = dir * 1000
	$CPUParticles2D.emitting = true
	$CPUParticles2D.reparent(Global.game, true)

func _process(delta: float) -> void:
	linear_velocity += dir

<<<<<<< HEAD
func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is TileMapLayer and !hit:
		hit = true
=======
func _on_area_2d_body_entered(body) -> void:
	if body is TileMapLayer:
		$Area2D.queue_free()
>>>>>>> 6565a6a0033a83a30c6db809bfcd58f7932caa37
		$BulletSprite/CPUParticles2D.queue_free()
		$BulletSprite.reparent(Global.game, true)
		$AudioStreamPlayer2D.stream = brick_hit
		$AudioStreamPlayer2D.volume_db = damage / 2
		$AudioStreamPlayer2D.playing = true
		await get_tree().create_timer(0.11).timeout
<<<<<<< HEAD
		queue_free()
	else:
		var enemy = body.get_groups()
		match enemy[0]:
			"NormalDino":
				$BulletSprite/CPUParticles2D.emitting = true
				$BulletSprite.reparent(body, true)
				body.health -= damage
				queue_free()
			"FlyingDino":
				$BulletSprite/CPUParticles2D.emitting = true
				$BulletSprite.reparent(body, true)
				body.health -= damage
				queue_free()
=======
	var hit_enemy = body.get_parent()
	if body is NormalDinoEnemy or body is FlyingDinoEnemy:
		$Area2D.queue_free()
		if Global.blood:
			$BulletSprite/CPUParticles2D.emitting = true
		$BulletSprite.reparent(body, true)
		body.health -= damage
		$AudioStreamPlayer2D.stream = flesh_hit
		$AudioStreamPlayer2D.playing = true
		await get_tree().create_timer(0.62).timeout
	queue_free()
>>>>>>> 6565a6a0033a83a30c6db809bfcd58f7932caa37

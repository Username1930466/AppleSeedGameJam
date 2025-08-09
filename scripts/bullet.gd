extends RigidBody2D

var brick_hit = preload("res://sounds/bullet_brick.mp3")
var flesh_hit = preload("res://sounds/flesh_hit.mp3")


var acceptable_enemies = ["NormalDino","FlyingDino","TurretDino"]
var damage: int
var bounces = 0
var pierces = 0

func _ready() -> void:
	$Area2D.area_entered.connect(_on_area_2d_body_entered)
	linear_velocity = Vector2.from_angle(rotation) * 1000
	$CPUParticles2D.emitting = true
	$CPUParticles2D.reparent(Global.game, true)

func _process(delta: float) -> void:
	linear_velocity += Vector2.from_angle(rotation)

func _on_area_2d_body_entered(body) -> void:
	if body is TileMapLayer:
		if bounces > 0:
			bounces -= 1
			rotation += deg_to_rad(90)
			linear_velocity = Vector2.from_angle(rotation) * 1000
			$AudioStreamPlayer2D.stream = brick_hit
			$AudioStreamPlayer2D.volume_db = damage / 2
			$AudioStreamPlayer2D.playing = true
		else:
			$Area2D.queue_free()
			$BulletSprite/CPUParticles2D.queue_free()
			$BulletSprite.reparent(Global.game, true)
			$AudioStreamPlayer2D.stream = brick_hit
			$AudioStreamPlayer2D.volume_db = damage / 2
			$AudioStreamPlayer2D.playing = true
			await get_tree().create_timer(0.11).timeout
			queue_free()
	else:
		var enemy = body.get_groups()
		if enemy[0] in acceptable_enemies:
			if pierces > 0:
				pierces -= 1
				body.take_damage(damage)
				$AudioStreamPlayer2D.stream = flesh_hit
				$AudioStreamPlayer2D.playing = true
			else:
				$Area2D.queue_free()
				if $BulletSprite:
					if Global.blood:
						$BulletSprite/CPUParticles2D.emitting = true
					$BulletSprite.reparent(body, true)
			body.take_damage(damage)
			$AudioStreamPlayer2D.stream = flesh_hit
			$AudioStreamPlayer2D.playing = true
			await get_tree().create_timer(0.62).timeout
			queue_free()

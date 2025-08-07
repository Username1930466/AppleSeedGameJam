extends RigidBody2D

var brick_hit = preload("res://sounds/bullet_brick.mp3")
var flesh_hit = preload("res://sounds/flesh_hit.mp3")


var acceptable_enemies = ["NormalDino","FlyingDino","TurretDino"]
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

func _on_area_2d_body_entered(body) -> void:
	if body is TileMapLayer:
		$Area2D.queue_free()
		$BulletSprite/CPUParticles2D.queue_free()
		$BulletSprite.reparent(Global.game, true)
		$AudioStreamPlayer2D.stream = brick_hit
		$AudioStreamPlayer2D.volume_db = damage / 2
		$AudioStreamPlayer2D.playing = true
		await get_tree().create_timer(0.11).timeout
	else:
		var enemy = body.get_groups()
		if enemy[0] in acceptable_enemies:
			$Area2D.queue_free()
			if Global.blood:
				$BulletSprite/CPUParticles2D.emitting = true
			$BulletSprite.reparent(body, true)
			body.health -= damage
			$AudioStreamPlayer2D.stream = flesh_hit
			$AudioStreamPlayer2D.playing = true
			await get_tree().create_timer(0.62).timeout
			queue_free()

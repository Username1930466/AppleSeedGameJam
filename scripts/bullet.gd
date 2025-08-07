extends RigidBody2D

var damage: int
var dir: Vector2
var hit = false

func _ready() -> void:
	$Area2D.area_entered.connect(_on_area_2d_body_entered)
	rotation = dir.angle()
	linear_velocity = dir * 1000
	$CPUParticles2D.emitting = true
	$CPUParticles2D.reparent(Global.game, true)

func _process(delta: float) -> void:
	linear_velocity += dir

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is TileMapLayer and !hit:
		hit = true
		$BulletSprite/CPUParticles2D.queue_free()
		$BulletSprite.reparent(Global.game, true)
		$AudioStreamPlayer2D.volume_db = damage / 2
		$AudioStreamPlayer2D.playing = true
		await get_tree().create_timer(0.11).timeout
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

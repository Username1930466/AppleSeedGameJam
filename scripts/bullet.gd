extends RigidBody2D

var damage: int
var dir: Vector2
var hit = false

func _ready() -> void:
	rotation = dir.angle()
	linear_velocity = dir * 1000
	$CPUParticles2D.emitting = true

func _process(delta: float) -> void:
	linear_velocity += dir

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMapLayer and !hit:
		hit = true
		$BulletSprite.reparent(Global.game, true)
		$AudioStreamPlayer2D.volume_db = damage / 2
		$AudioStreamPlayer2D.playing = true
		await get_tree().create_timer(0.11).timeout
		queue_free()

extends RigidBody2D


var dir : Vector2
var pos: Vector2
var damage : float = 12
var hit = false
var bullet_speed = 500

func _ready():
	linear_velocity = dir * bullet_speed
	rotation = dir.angle()
	
func _physics_process(delta):
	linear_velocity += dir

func _on_area_2d_body_entered(body):
	if body is TileMapLayer:
		$AudioStreamPlayer2D.volume_db = damage / 2
		$AudioStreamPlayer2D.playing = true
		await $AudioStreamPlayer2D.finished
		queue_free()
	else:
		var player = body.get_groups()
		if player[0] == "Player":
			body.health -= damage
		queue_free()

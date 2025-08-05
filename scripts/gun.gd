extends Sprite2D

@export var cooldown_length = 0.25
@export var norm_output_pos = Vector2(128, -64)
@export var flip_output_pos = Vector2(128, 64)

var bullet_scene = preload("res://scenes/bullet.tscn")
var dir: Vector2
var cooldown = 0.0

func _process(delta: float):
	 # Rotate gun
	var mouse_pos = get_global_mouse_position()
	dir = (mouse_pos - global_position).normalized()
	rotation = dir.angle()
	flip_v = (abs(rotation_degrees) > 90 and abs(rotation_degrees) < 270)
	if flip_v:
		$Output.position = flip_output_pos
	else:
		$Output.position = norm_output_pos
	
	 # Cooldown
	cooldown -= delta
	
	 # Shoot
	if Input.is_action_pressed("shoot") and cooldown <= 0:
		cooldown = cooldown_length
		var bullet = bullet_scene.instantiate()
		bullet.dir = dir
		bullet.position = $Output.global_position
		Global.game.add_child(bullet)
		Global.screenshake(20, 0.01, 3)

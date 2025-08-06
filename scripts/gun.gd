extends Sprite2D

var min_damage: int
var max_damage: int
var cooldown_length: float
var capacity: int
var reload_time: float

var norm_output_pos = Vector2(112, -40)
var flip_output_pos = Vector2(112, 40)

var bullet_scene = preload("res://scenes/bullet.tscn")
var dir: Vector2
var ammo: int
var cooldown = 0.0
var reload_cooldown = 0.0
var reloading = false

func _ready() -> void:
	min_damage = Global.current_dino.gun.min_damage
	max_damage = Global.current_dino.gun.max_damage
	cooldown_length = Global.current_dino.gun.cooldown
	capacity = Global.current_dino.gun.capacity
	ammo = capacity
	reload_time = Global.current_dino.gun.reload_time

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
	if Input.is_action_pressed("shoot") and cooldown <= 0 and ammo > 0:
		cooldown = cooldown_length
		ammo -= 1
		var bullet = bullet_scene.instantiate()
		bullet.dir = dir
		bullet.position = $Output.global_position
		bullet.damage = randi_range(min_damage, max_damage)
		Global.game.add_child(bullet)
		if Global.screenshake:
			Global.cam.screenshake(bullet.damage, 0.01, cooldown_length * 6)
		$Output/AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 1.2)
		$Output/AudioStreamPlayer2D.playing = true
	
	 # Reload
	if Input.is_action_just_pressed("reload"):
		if !reloading:
			reloading = true
			reload_cooldown = reload_time
	
	reload_cooldown -= delta
	if reload_cooldown <= 0 and reloading:
		reloading = false
		ammo = capacity

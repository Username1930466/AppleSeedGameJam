extends Sprite2D

var min_damage: int
var max_damage: int
var cooldown_length: float
var capacity: int
var reload_time: float

var norm_output_pos = Vector2(82, -39)
var flip_output_pos = Vector2(82, 9)

var bullet_scene = preload("res://scenes/bullet.tscn")
var dir: Vector2
var ammo: int
var cooldown = 0.0
var reload_cooldown = 0.0
var reloading = false
var total_bullet_damage = 0




func _ready() -> void:
	min_damage = Global.current_dino.gun.min_damage
	max_damage = Global.current_dino.gun.max_damage
	cooldown_length = Global.current_dino.gun.cooldown
	capacity = Global.current_dino.gun.capacity
	ammo = capacity
	reload_time = Global.current_dino.gun.reload_time
	texture = Global.current_dino.gun.gun_texture
	position += Global.current_dino.gun.pos
	
	
func _process(delta: float):
	 # Rotate gun
	var mouse_pos = get_global_mouse_position()
	dir = (mouse_pos - global_position).normalized()
	rotation = dir.angle()
	if !flip_h:
		rotation += deg_to_rad(180)
	flip_v = (abs(rotation_degrees) > 90 and abs(rotation_degrees) < 270)
	if flip_v:
		$Output.position = flip_output_pos
	else:
		$Output.position = norm_output_pos
	
	 # Cooldown
	cooldown -= delta
	
	 # Shoot
	if Input.is_action_pressed("shoot") and cooldown <= 0 and ammo > 0 and !reloading:
		cooldown = cooldown_length
		
		 # Bullet & Multishot
		total_bullet_damage = 0
		spawn_bullet(dir.angle())
		for i in Global.upgrades["Multishot"]:
			if i % 2 == 0:
				spawn_bullet(dir.angle() + deg_to_rad(((i / 2) + 1) * 5))
			else:
				spawn_bullet(dir.angle() - deg_to_rad(((i / 2) + 1) * 5))
		
		if Global.screenshake:
			Global.cam.screenshake(total_bullet_damage, 0.025, cooldown_length * 6)
		$Output/AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 1.2)
		$Output/AudioStreamPlayer2D.playing = true
		
		 # Bullet & Double Shot
		for i in Global.upgrades["Double Shot"]:
			await get_tree().create_timer(0.1).timeout
			
			 # Bullet & Multishot
			total_bullet_damage = 0
			spawn_bullet(dir.angle())
			for j in Global.upgrades["Multishot"]:
				if j % 2 == 0:
					spawn_bullet(dir.angle() + deg_to_rad(((j / 2) + 1) * 5))
				else:
					spawn_bullet(dir.angle() - deg_to_rad(((j / 2) + 1) * 5))
			
			if ammo > 0:
				if Global.screenshake:
					Global.cam.screenshake(total_bullet_damage, 0.025, cooldown_length * 6)
				$Output/AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 1.2)
				$Output/AudioStreamPlayer2D.playing = true
	
	 # Reload
	if Input.is_action_just_pressed("reload") || ammo == 0:
		if !reloading:
			reloading = true
			reload_cooldown = reload_time * (1 - (float(Global.upgrades["Faster Reload"]) / 10.0))
	
	reload_cooldown -= delta
	if reload_cooldown <= 0 and reloading:
		reloading = false
		ammo = capacity

func spawn_bullet(_rotation: float):
	if ammo > 0:
		ammo -= 1
		var bullet = bullet_scene.instantiate()
		bullet.rotation = _rotation
		bullet.position = $Output.global_position
		bullet.damage = randi_range(min_damage, max_damage)
		total_bullet_damage += bullet.damage
		bullet.bounces = Global.upgrades["Ricohet"]
		bullet.pierces = Global.upgrades["Pierce"]
		Global.game.add_child(bullet)

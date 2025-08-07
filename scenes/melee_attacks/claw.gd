extends Area2D

var attacking = false
var damage: float
var defense_pierce: float
var cooldown_length: float

var cooldown = 0.0

func _ready() -> void:
	damage = Global.current_dino.melee_attack.damage
	defense_pierce = Global.current_dino.melee_attack.defence_pierce
	cooldown_length = Global.current_dino.melee_attack.cooldown

func _process(delta: float) -> void:
	 # Rotate claws
	if !attacking:
		var mouse_pos = get_global_mouse_position()
		var dir = (mouse_pos - global_position).normalized()
		rotation = dir.angle() + deg_to_rad(133.3)
	
	cooldown -= delta
	
	 # Claw
	if Input.is_action_just_pressed("melee") and !attacking and cooldown <= 0:
		cooldown = cooldown_length
		attacking = true
		claw()

func claw():
	$ClawPlayer.playing = true
	visible = true
	$CollisionPolygon2D.disabled = false
	await get_tree().create_timer(0.5).timeout
	$CollisionPolygon2D.disabled = true
	visible = false
	attacking = false

func _on_body_entered(body: Node2D) -> void:
	if body is NormalDinoEnemy or body is FlyingDinoEnemy:
		body.health -= damage
		$FleshPlayer.playing = true
	if body is TileMapLayer:
		$BrickPlayer.volume_db = damage / 2
		$BrickPlayer.playing = true

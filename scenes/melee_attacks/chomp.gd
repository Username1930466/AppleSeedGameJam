extends Area2D

var chomping = false
var damage: float
var defense_pierce: float
var cooldown_length: float

var cooldown = 0.0

func _ready() -> void:
	damage = Global.current_dino.melee_attack.damage
	defense_pierce = Global.current_dino.melee_attack.defence_pierce
	cooldown_length = Global.current_dino.melee_attack.cooldown

func _process(delta: float) -> void:
	 # Rotate teeth
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	rotation = dir.angle() + deg_to_rad(90)
	
	cooldown -= delta
	
	 # Chomp
	if Input.is_action_just_pressed("melee") and !chomping and cooldown <= 0:
		cooldown = cooldown_length
		chomping = true
		chomp()

func chomp():
	$CollisionShape2D.position = Vector2i(-20, -24)
	$CollisionShape2D2.position = Vector2i(20, -24)
	visible = true
	$CollisionShape2D.disabled = false
	$CollisionShape2D2.disabled = false
	await get_tree().create_timer(0.5).timeout
	$CollisionShape2D.position = Vector2i(-4, -24)
	$CollisionShape2D2.position = Vector2i(4, -24)
	await get_tree().create_timer(0.5).timeout
	$CollisionShape2D.disabled = true
	$CollisionShape2D2.disabled = true
	visible = false
	chomping = false

func _on_body_entered(body: Node2D) -> void:
	var enemy = body.get_groups()
	match enemy[0]:
		"NormalDino":
			body.health -= damage
		"FlyingDino":
			pass

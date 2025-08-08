extends CharacterBody2D

var speed: float
var defense: float
var max_health: float
var health: float
var exp_needed = 100
var exp = 0

func _ready() -> void:
	$Sprite2D.texture = Global.current_dino.texture
	speed = Global.current_dino.speed
	defense = Global.current_dino.defense
	max_health = Global.current_dino.max_health
	health = max_health
	var melee = Global.current_dino.melee_attack.scene.instantiate()
	add_child(melee)
	melee.name = "Melee"

func _process(delta: float) -> void:
	if exp >= exp_needed:
		$"../UI/UpgradeMenu".upgrade()

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_vector.normalized() * speed
	move_and_slide()

func take_damage(damage):
	health -= damage

extends CharacterBody2D

var speed: float
var defense: float
var max_health: float
var health: float
var exp_needed = 100
var exp = 0
var idle_anim: String
var walking_anim: String

func _ready() -> void:
	idle_anim = Global.current_dino.idle_anim
	walking_anim = Global.current_dino.walking_anim
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
	if velocity == Vector2.ZERO:
		$Sprite2D.animation = idle_anim
	else:
		$Sprite2D.animation = walking_anim
	move_and_slide()

func take_damage(damage):
	health -= damage

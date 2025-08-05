extends CharacterBody2D

var speed: float
var defense: float
var max_health: float
var health: float

func _ready() -> void:
	$Sprite2D.texture = Global.current_dino.texture
	speed = Global.current_dino.speed
	defense = Global.current_dino.defense
	max_health = Global.current_dino.max_health
	health = max_health

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_vector.normalized() * speed
	move_and_slide()

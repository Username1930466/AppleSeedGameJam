extends CharacterBody2D

var speed: float
var defense: float
var max_health: float
var health: float
var exp_needed = 100
var exp = 0
var idle_anim: String
var walking_anim: String

var can_walk = true
var menu_scene = "res://scenes/Menu.tscn"

var boss_music = preload("res://sounds/music/Boss.mp3")

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
	if can_walk:
		var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_vector.normalized() * speed
	if velocity == Vector2.ZERO:
		$Sprite2D.play(idle_anim)
	else:
		$Sprite2D.play(walking_anim)
		if velocity.x < 0:
			$Sprite2D.flip_h = false
			$Gun.flip_h = false
			$Gun.offset = Vector2i(-32, -15)
			$Gun.position = Vector2i(-53, 16)
		else:
			$Sprite2D.flip_h = true
			$Gun.flip_h = true
			$Gun.offset = Vector2i(32, -15)
			$Gun.position = Vector2i(53, 16)
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		$Sprite2D.flip_v = true
		$"../UI/YouDiedLabel".visible = true
		process_mode = Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true
		can_walk = false
		await get_tree().create_timer(2.5).timeout
		get_tree().change_scene_to_file(menu_scene)

func play_boss_music():
	$Music.stream = boss_music
	$Music.playing = true

extends Node2D

var upgrade_icons = {"Multishot": preload("res://textures/upgrades/multishot_icon.png"),
	"Double Shot": preload("res://textures/upgrades/double_shot_icon.png"),
	"Ricohet": preload("res://textures/upgrades/ricohet_icon.png"),
	"Pierce": preload("res://textures/upgrades/pierce_icon.png"),
	"Faster Reload": preload("res://textures/upgrades/faster_reload_icon.png")}
var upgrade_descriptions = {"Multishot": "Shoots an extra bullet at an angle with each shot. Still consume the amount of bullets you shoot.",
	"Double Shot": "Shoots an extra bullet right after each shot. Still consume the amount of bullets you shoot.",
	"Ricohet": "Bullets bounce off walls one extra time.",
	"Pierce": "Bullets go through one extra enemy.",
	"Faster Reload": "Gun reloads 10% faster."}
var upgrade_pool: Array
var upgrade_1: String
var upgrade_2: String
var upgrade_3: String
var hovered = null
var upgrade_menu = false

func upgrade():
	upgrade_menu = true
	hovered = null
	get_tree().paused = true
	$"../../Player".exp_needed = $"../../Player".exp_needed * 1.5
	
	upgrade_pool.append("Multishot")
	upgrade_pool.append("Double Shot")
	upgrade_pool.append("Ricohet")
	upgrade_pool.append("Pierce")
	if Global.upgrades["Faster Reload"] <= 10:
		upgrade_pool.append("Faster Reload")
	
	var num = randi_range(0, upgrade_pool.size() - 1)
	upgrade_1 = upgrade_pool[num]
	upgrade_pool.erase(num)
	num = randi_range(0, upgrade_pool.size() - 1)
	upgrade_2 = upgrade_pool[num]
	upgrade_pool.erase(num)
	num = randi_range(0, upgrade_pool.size() - 1)
	upgrade_3 = upgrade_pool[num]
	
	$Upgrade1.texture_normal = upgrade_icons[upgrade_1]
	$Upgrade2.texture_normal = upgrade_icons[upgrade_2]
	$Upgrade3.texture_normal = upgrade_icons[upgrade_3]
	visible = true
	selection()

func _on_upgrade_1_mouse_entered() -> void:
	hovered = 1
	$Upgrade1.scale = Vector2i(6, 6)
	$UpgradeDescLabel.text = upgrade_descriptions[upgrade_1]

func _on_upgrade_1_mouse_exited() -> void:
	hovered = null
	$Upgrade1.scale = Vector2i(5, 5)
	$UpgradeDescLabel.text = ""

func _on_upgrade_2_mouse_entered() -> void:
	hovered = 2
	$Upgrade2.scale = Vector2i(6, 6)
	$UpgradeDescLabel.text = upgrade_descriptions[upgrade_2]

func _on_upgrade_2_mouse_exited() -> void:
	hovered = null
	$Upgrade2.scale = Vector2i(5, 5)
	$UpgradeDescLabel.text = ""

func _on_upgrade_3_mouse_entered() -> void:
	hovered = 3
	$Upgrade3.scale = Vector2i(6, 6)
	$UpgradeDescLabel.text = upgrade_descriptions[upgrade_3]

func _on_upgrade_3_mouse_exited() -> void:
	hovered = null
	$Upgrade3.scale = Vector2i(5, 5)
	$UpgradeDescLabel.text = ""

func selection():
	while upgrade_menu:
		if Input.is_action_just_pressed("shoot") and hovered:
			if hovered == 1:
				Global.upgrades[upgrade_1] += 1
			elif hovered == 2:
				Global.upgrades[upgrade_2] += 1
			else:
				Global.upgrades[upgrade_3] += 1
			visible = false
			get_tree().paused = false
			upgrade_menu = false
		await get_tree().process_frame

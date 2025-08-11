extends Node2D


var enemy = preload("res://scenes/Enemies/normal_dino.tscn")
var exp = preload("res://scenes/exp.tscn")
var player


func _ready():
	player = get_tree().get_first_node_in_group("Player")


func _process(delta):
	if Input.is_action_just_pressed("interact"):
		$HBoxContainer.visible = true

func _on_yes_pressed():
	$HBoxContainer.visible = false
	$Label.visible = false
	for i in 50:
		var new_enemy = enemy.instantiate()
		new_enemy.global_position = player.global_position
		Global.game.add_child(new_enemy)




func _on_no_pressed():
	$Label.text = "Well, at least have this."
	$HBoxContainer/Onexp.visible = true
	$HBoxContainer/Yes.visible = false
	$HBoxContainer/No.visible = false

func _on_onexp_pressed():
	$HBoxContainer.visible = false
	var new_exp = exp.instantiate()
	new_exp.position = global_position
	Global.game.add_child(new_exp)
	$Label.visible = false

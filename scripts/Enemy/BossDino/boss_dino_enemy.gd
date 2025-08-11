extends CharacterBody2D
class_name BossDinoEnemy

var health := 1000.0

var camera : Camera2D

func _ready():
	pass


func take_damage(damage):
	health -= damage

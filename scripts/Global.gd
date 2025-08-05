extends Node

 # Refs
var game: Node2D
var player: CharacterBody2D
var cam: Camera2D
var paused = false
var current_dino = preload("res://resources/dinos/raptor.tres")
var available_dinos = {0: preload("res://resources/dinos/t_rex.tres"), 1: preload("res://resources/dinos/raptor.tres")}

 # Settings
var screenshake = true

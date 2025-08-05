extends CharacterBody2D

@export var speed = 5

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += input_vector.normalized() * speed
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		position += input_vector * speed

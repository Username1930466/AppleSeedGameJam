extends Area2D

var speed = 500

func _physics_process(delta: float) -> void:
	var direction = (Global.player.global_position - position).normalized()
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	Global.player.exp += 1
	queue_free()

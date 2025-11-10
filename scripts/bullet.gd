class_name Bullet
extends Area2D

var shooter : String
var speed := 440

func _process(delta: float) -> void:
	if shooter == "Player":
		position.y -= speed * delta
	else :
		position.y += speed * delta

func _on_body_entered(body:Node2D) -> void:
	if body.type != shooter:
		body.hurt()
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

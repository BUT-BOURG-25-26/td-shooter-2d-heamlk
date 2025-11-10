extends CharacterBody2D

@export var shoot_timer : Timer
var health := 2
var type : = "Enemy"

func _ready() -> void:
	shoot_timer.timeout.connect(shoot)
	velocity.y = 400
	var tween = create_tween()
	var target_y = position.y + randi_range(-50, 50)
	tween.tween_property(self, "position:y", target_y, 0.3)
	tween.tween_property(self, "position:y", -target_y, 0.3)
	tween.tween_property(self, "position:y", target_y, 0.3)
	tween.tween_property(self, "position:y", -target_y, 0.3)


func shoot():
	var bullet : Area2D = load("res://scenes/bullet.tscn").instantiate()
	bullet.shooter = "Enemy"
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
	shoot_timer.start()

func hurt():
	health -= 1
	
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
	
	if health <= 0:
		die()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func die() -> void:
	GameManager.score += 100
	get_parent().HUD.update_score.emit()
	queue_free()

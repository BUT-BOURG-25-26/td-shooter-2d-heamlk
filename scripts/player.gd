extends CharacterBody2D

@export var shoot_timer : Timer
@export var HUD : Control

const SPEED := 300.0

var health : int = 4
var type := "Player"

func _ready() -> void:
	shoot_timer.timeout.connect(shoot)

func _physics_process(_delta: float) -> void:
	if health == 0:
		die()
	
	var direction : float = 0
	if ((get_global_mouse_position().x <= 400 and Input.is_action_pressed("click")) or Input.is_action_pressed("left")) and position.x > 0:
		direction = -1
	elif  ((get_global_mouse_position().x > 400 and Input.is_action_pressed("click")) or Input.is_action_pressed("right")) and position.x < 800:
		direction = 1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide() 

func hurt() -> void:
	HUD.update_health.emit()
	health -= 1

func shoot() -> void:
	var bullet : Area2D = load("res://scenes/bullet.tscn").instantiate()
	bullet.shooter = name
	bullet.position = position
	owner.add_child(bullet)
	shoot_timer.start()

func die() -> void:
	get_tree().change_scene_to_file.bind("res://scenes/game_over.tscn").call_deferred()

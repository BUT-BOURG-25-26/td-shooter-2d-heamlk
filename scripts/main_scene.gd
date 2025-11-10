extends Node2D

@export var enemy_spawn_timer : Timer
@export var enemy_spawn_container : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_spawn_timer.timeout.connect(spawn)

func spawn() -> void:
	var enemy : CharacterBody2D = load("res://scenes/enemy.tscn").instantiate()
	enemy.position = Vector2(randi_range(50, 750), 0)
	enemy_spawn_container.add_child(enemy)
	enemy_spawn_timer.start()

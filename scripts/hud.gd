extends Control

signal update_health
signal update_score
var path : String = "res://KennyAssets/SpaceShooterRedux/score/"
@export var score_container : HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoring()
	update_health.connect(hurt)
	update_score.connect(scoring)

func hurt():
	get_child(0).get_child(0).queue_free()

func scoring() -> void:
	for child in score_container.get_children():
		child.queue_free()
	for i in str(GameManager.score):
		var num = TextureRect.new()
		score_container.add_child(num)
		num.position = Vector2(10, 10)
		num.texture = load(path + i + ".png")

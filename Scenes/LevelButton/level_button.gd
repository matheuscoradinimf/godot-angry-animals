extends TextureButton

@export var level_number: String = "1"

@onready var LevelLabel: Label = $MC/VBoxContainer/LevelLabel
@onready var LevelScoreLabel: Label = $MC/VBoxContainer/LevelLabel2

func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)

func _on_mouse_entered() -> void:
	scale = Vector2(1.15, 1.15)

func _ready() -> void:
	LevelLabel.text = level_number
	LevelScoreLabel.text = str(ScoreManager.get_level_best(level_number))

func _on_pressed() -> void:
	ScoreManager.level_selected = level_number
	get_tree().change_scene_to_file("res://Scenes/LevelBase/level_%s.tscn" % level_number)

extends Control


var _attempts: int = 0

@onready var LevelLabel: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var AttempsLabel: Label = $MarginContainer/VBoxContainer/AttempsLabel
@onready var Music: AudioStreamPlayer = $Music
@onready var LevelComplete: Label = $MarginContainer/VBoxContainer2/LevelComplete
@onready var LevelSpace: Label = $MarginContainer/VBoxContainer2/LevelSpace

func _ready() -> void:
	LevelComplete.hide()
	LevelSpace.hide()
	LevelLabel.text = "Level %s" % ScoreManager.level_selected

func _enter_tree() -> void:
	SignalHub.on_attempt_made.connect(attempt_made)
	SignalHub.on_cup_destroyed.connect(cup_destroyed)

func attempt_made() -> void:
	_attempts += 1
	AttempsLabel.text = "Attempts: %s" % _attempts

func cup_destroyed(remaining_cups: int) -> void:
	if remaining_cups == 0:
		LevelComplete.show()
		LevelSpace.show()
		Music.play()
		ScoreManager.set_score_for_level(ScoreManager.level_selected, _attempts)

	

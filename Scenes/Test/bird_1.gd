extends RigidBody2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "CC:%d\nFZ:%s\nSL:%s" % [get_contact_count(), freeze, sleeping]

func _on_sleeping_state_changed() -> void:
	print("sleeping state changed")

func _on_timer_timeout() -> void:
	freeze = false

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.button_mask==1 and InputEventMouseMotion:
		position = get_global_mouse_position()
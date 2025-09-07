extends RigidBody2D

enum AnimalState { Ready, Drag, Release }

const DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)
const IMPULSE_MULT: float = 20.0
const IMPULSE_MAX: float = 1200.0

@onready var arrow: Sprite2D = $Arrow
@onready var debug_label: Label = $DebugLabel
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound

var _state: AnimalState = AnimalState.Ready
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if _state == AnimalState.Drag and event.is_action_released("drag"):
		call_deferred("change_state", AnimalState.Release)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()

func setup() -> void:
	_arrow_scale_x = arrow.scale.x
	arrow.hide()
	_start = position

# region misc

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_state()
	update_debug_label()

func update_debug_label() -> void:
	var ds: String = "ST:%s SL:%s FR:%s\n" % [
		AnimalState.keys()[_state], sleeping, freeze
		]
	ds += "drag_start: %.1f, %.1f\n" % [_drag_start.x, _drag_start.y]
	ds += "drag_vector: %.1f, %.1f" % [_dragged_vector.x, _dragged_vector.y]
	debug_label.text = ds

func die() -> void:
	SignalHub.on_animal_died.emit()
	queue_free()


# endregion 

# region drag

func update_arrow_scale() -> void:
	var imp_len: float = calculate_impulse().length()
	var perc: float = clamp(imp_len / IMPULSE_MAX, 0.0, 1.0)
	arrow.scale.x = lerp(_arrow_scale_x, _arrow_scale_x*2, perc)
	arrow.rotation = (_start - position).angle()

func start_dragging() -> void:
	arrow.show()
	_drag_start = get_global_mouse_position()

func handle_dragging() -> void:
	var new_dragged_vector: Vector2 = get_global_mouse_position() - _drag_start

	new_dragged_vector = new_dragged_vector.clamp(
		DRAG_LIM_MIN,
		DRAG_LIM_MAX
	)

	var diff: Vector2 = new_dragged_vector - _dragged_vector

	if diff.length() > 0 and stretch_sound.playing==false:
		stretch_sound.play()

	_dragged_vector = new_dragged_vector
	position = _start + _dragged_vector
	update_arrow_scale()

# endregion

func calculate_impulse() -> Vector2:
	return _dragged_vector * -IMPULSE_MULT

func start_release() -> void:
	arrow.hide()
	launch_sound.play()
	freeze = false
	apply_central_impulse(calculate_impulse())

# endregion

# region state

func update_state() -> void:
	match _state:
		AnimalState.Drag:
			handle_dragging()

func change_state(new_state: AnimalState) -> void:
	if _state == new_state:
		return
	
	_state = new_state

	match _state:
		AnimalState.Drag:
			start_dragging()
		AnimalState.Release:
			start_release()

# endregion 

# region signals

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag") and _state == AnimalState.Ready:
		change_state(AnimalState.Drag)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()

func _on_sleeping_state_changed() -> void:
	pass

func _on_body_entered(body: Node) -> void:
	pass

# endregion

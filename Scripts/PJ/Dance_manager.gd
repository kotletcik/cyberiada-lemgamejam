extends Node
class_name Dance_manager

static var instance: Dance_manager

@onready var ui: Control = $Dance
@export var label: Label
var is_dance
var is_checking_input
var current_label_input: inputs
var input_window_time:= 0.8
@export var mistake_shader: Sprite2D
var timer:= 0.0
var waiting_to_next_step = true
var shader_timer :=0.0

enum inputs{
	W,
	S,
	A,
	D
}

func _ready() -> void:
	if (instance != null):
		print ("more than one cycle manager exists")
		instance.queue_free()
	instance = self
	EventBus.day_static_dance_started.connect(enable_dance)
	EventBus.light_is_switched.connect(disable_dance_if_is_night)
	EventBus.step_is_past.connect(timer_to_zero)
	erase_input_label()
	
func _physics_process(delta: float) -> void:
	if (is_dance):
		if (timer > (Cycle_manager.instance.phase_step_duration - input_window_time) && !is_checking_input && !waiting_to_next_step):
			generate_input_label()
		else: timer += delta
	else: timer = 0
	
func timer_to_zero():
	timer = 0;
	if (is_checking_input):
		MistakeManager.instance.register_mistake();
		mistake_animation()
	waiting_to_next_step = false

func enable_dance():
	is_dance = true
	ui.visible = true

func disable_dance_if_is_night(is_day: bool):
	if (!is_day):
		is_dance = false
		ui.visible = false
		is_checking_input = false

func generate_input_label():
	var rng = RandomNumberGenerator.new()
	var rand: int = rng.randi_range(0, 3);
	current_label_input = rand
	label.text = inputs.keys()[current_label_input]
	is_checking_input = true

func erase_input_label():
	label.text = ""
	is_checking_input = false

func validate_dance(dance: int):
	if (is_checking_input):
		if (dance != current_label_input):
			MistakeManager.instance.register_mistake();
			mistake_animation()
		else:
			print("correct");
			erase_input_label()
			waiting_to_next_step = true;
		is_checking_input = false

func mistake_animation():
	mistake_shader.visible = true;
	if (is_inside_tree()):
		await self.get_tree().create_timer(0.2).timeout
	mistake_shader.visible = false;

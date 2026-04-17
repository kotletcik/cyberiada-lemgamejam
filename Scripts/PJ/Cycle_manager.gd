extends Node
class_name Cycle_manager

var is_day: bool
var current_time_step: int = 0
var timer: float
@export var phase_step_duration = 1;
@export var light_steps_count = 8;
@export var dark_steps_count = 8;
static var instance: Cycle_manager

func _ready() -> void:
	if (instance != null):
		print ("more than one cycle manager exists")
		instance.queue_free()
	instance = self
	print (instance)

func _physics_process(delta: float) -> void:
	if (timer > phase_step_duration):
		EventBus.step_is_past.emit()
		current_time_step += 1
		print ("step number: ", current_time_step)
		if ((is_day && current_time_step >= light_steps_count) || (!is_day && current_time_step >= dark_steps_count)):
			EventBus.light_is_switched.emit(!is_day)
			switch_light()
			#current_time_step = 0
		timer = 0
	else:
		timer += delta

func switch_light():
	is_day = !is_day
	print ("light switched")

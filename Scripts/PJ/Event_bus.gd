extends Node
class_name Event_bus

signal step_is_past()
signal light_is_switched(to_day: bool)
signal day_static_dance_started()

enum triggers
{
	None,
	step_is_past,
	light_is_switched,
	day_static_dance_started
}

func reset_signal_subscribers():
	_disconnect_all("step_is_past")
	_disconnect_all("light_is_switched")
	_disconnect_all("day_static_dance_started")

func _disconnect_all(signal_name: String):
	var connections = get_signal_connection_list(signal_name)
	for c in connections:
		if(is_connected(signal_name, c.callable)):
			disconnect(signal_name, c.callable)

func call_event(trigger: triggers):
	match trigger:
		triggers.step_is_past:
			step_is_past.emit();
		triggers.light_is_switched:
			light_is_switched.emit();
		triggers.day_static_dance_started:
			day_static_dance_started.emit();
		triggers.None:
			return;
	
	

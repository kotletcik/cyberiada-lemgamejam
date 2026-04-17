extends Node
class_name Event_bus

signal step_is_past()
signal light_is_switched(to_day: bool)

enum triggers
{
	None,
	step_is_past,
	light_is_switched
}

func reset_signal_subscribers():
	_disconnect_all("step_is_past")
	_disconnect_all("light_is_switched")

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
		triggers.None:
			return;
	
	

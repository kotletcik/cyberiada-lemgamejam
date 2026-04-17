extends Node

@export var cursor_locked: bool;

func _ready() -> void:
	if(cursor_locked):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);


func _process(delta: float) -> void:
	pass

class_name DisappearAfterTime
extends Node

@export var timer: float;

var time_left: float;

func _ready() -> void:
	time_left = timer;

func _process(delta: float) -> void:
	time_left -= delta;
	if(time_left < 0):
		get_parent().visible = false;
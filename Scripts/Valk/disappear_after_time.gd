class_name DisappearAfterTime
extends Node

@export var label: Label
@export var timer: float;
@export var time_intervals: Array[float]
@export var notes: Array[String]

var time_left: float;

func _ready() -> void:
	time_left = timer;

func _process(delta: float) -> void:
	time_left -= delta;
	if(time_left < time_intervals[0]):
		label.text = notes[0]
	if(time_left < time_intervals[1]):
		label.text = notes[1]
	if(time_left < time_intervals[2]):
		get_parent().visible = false;

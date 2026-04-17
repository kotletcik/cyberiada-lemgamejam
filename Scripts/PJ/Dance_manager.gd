extends Node
class_name Dance_manager

static var instance: Dance_manager

func _ready() -> void:
	if (instance != null):
		print ("more than one cycle manager exists")
		instance.queue_free()
	instance = self
	

extends CharacterBody2D
class_name PlayerController

@export var speed: float;

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	var horizontal_direction: float = Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left");
	var vertical_direction: float = Input.get_action_strength("Move Forward") - Input.get_action_strength("Move Backward"); 

	velocity.x = horizontal_direction * speed; 
	velocity.y = vertical_direction * speed;




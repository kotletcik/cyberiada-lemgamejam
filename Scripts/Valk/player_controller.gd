extends CharacterBody2D
class_name PlayerController

@export var speed: float;

var movement_locked: bool = false;

func _ready() -> void:
	EventBus.light_is_switched.connect(enable_movement_on_night);
	EventBus.day_static_dance_started.connect(disable_movement);

func change_movement_lock(value: bool):
	movement_locked = value;

func disable_movement():
	movement_locked = true;
	print("movement disabled")
	
func enable_movement_on_night(is_day: bool):
	if (!is_day):
		movement_locked = false;
		print("movement enabled")

func _process(delta: float) -> void:
	if(!movement_locked):
		var direction: Vector2;
		direction.x = Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left");
		direction.y = Input.get_action_strength("Move Backward") - Input.get_action_strength("Move Forward"); 

		velocity = direction * speed;

		move_and_slide();
	else:
		if(Input.is_action_just_pressed("Move Forward")):
			Dance_manager.instance.validate_dance(0);
		if(Input.is_action_just_pressed("Move Backward")):
			Dance_manager.instance.validate_dance(1);
		if(Input.is_action_just_pressed("Move Left")):
			Dance_manager.instance.validate_dance(2);
		if(Input.is_action_just_pressed("Move Right")):
			Dance_manager.instance.validate_dance(3);

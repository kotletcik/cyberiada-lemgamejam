extends CharacterBody2D
class_name PlayerController

@export var speed: float;

@export var light_mode: bool = true;

func _process(delta: float) -> void:
	if(light_mode):
		var direction: Vector2;
		direction.x = Input.get_action_strength("Move Right") - Input.get_action_strength("Move Left");
		direction.y = Input.get_action_strength("Move Backward") - Input.get_action_strength("Move Forward"); 

		velocity = direction * speed;

		move_and_slide();
	else:
		if(Input.is_action_just_pressed("Move Forward")):
			validate_dance(0);
		if(Input.is_action_just_pressed("Move Backward")):
			validate_dance(1);
		if(Input.is_action_just_pressed("Move Left")):
			validate_dance(2);
		if(Input.is_action_just_pressed("Move Right")):
			validate_dance(3);

func validate_dance(dance: int):
	var rng = RandomNumberGenerator.new()
	var rand: int = rng.randi_range(0, 3);

	if(dance != rand):
		MistakeManager.instance.register_mistake();
	else:
		print("correct");

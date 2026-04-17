extends CharacterBody2D
class_name PlayerController

@export var speed: float;
@export var interaction_range: float;

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

	if(Input.is_action_just_pressed("Interact")):
		var tasks = get_tree().get_nodes_in_group("tasks");
		for i in range(0, tasks.size()):
			var scene_task: SceneTask = tasks[i] as SceneTask;
			if(scene_task.global_position.distance_to(global_position) < interaction_range):
				scene_task.complete_task();
				TaskManager.instance.complete_task();
				break;

	if(!movement_locked):
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
	#chwilowo random
	var rng = RandomNumberGenerator.new()
	var rand: int = rng.randi_range(0, 3);

	if(dance != rand):
		MistakeManager.instance.register_mistake();
	else:
		print("correct");

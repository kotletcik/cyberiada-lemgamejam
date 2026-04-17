extends Node
class_name TaskManager

enum tasks {
	None,
	Test1,
	Test2,
	Test3,
	Test4,
	Test5,
	Test6,
	Test7,
	Test8,
	Test9,
}

static var instance: TaskManager;

@export var generated_tasks: Array[tasks] = [tasks.None];
@export var scene_tasks: Array[SceneTask] = [null];
var first_free_index: int;

var completed_tasks_count: int = 0;

func turn_on_current_task():
	scene_tasks[completed_tasks_count].visible = true;

func get_next_task() -> tasks:
	return generated_tasks[completed_tasks_count];

func _ready() -> void:
	if(instance == null):
		instance = self;   
		generated_tasks.resize(9);
		for i in range(0, generated_tasks.size()):
			generated_tasks[i] = tasks.None;
		for i in range(0, scene_tasks.size()):
			scene_tasks[i].visible = false;
		scene_tasks[0].visible = true;
		first_free_index = 0;
		generate_next_tasks();

func _process(delta: float) -> void:
	pass

func is_task_generated(task: tasks):
	for i in range(0, first_free_index):
		if(generated_tasks[i] == task):
			return true;
	return false;

func get_new_task() -> tasks:
	var random: int = randi_range(1, tasks.size() - 1);
	while(is_task_generated(tasks.get(tasks.find_key(random)))):
		random = randi_range(1, tasks.size() - 1);
	return tasks.get(tasks.find_key(random));

func generate_next_tasks():
	var start_index = first_free_index;
	var end_index: = first_free_index + 3;
	for i in range(start_index, end_index):
		generated_tasks[first_free_index] = get_new_task();
		first_free_index += 1;

func complete_task():
	scene_tasks[completed_tasks_count].visible = false;
	completed_tasks_count += 1;
	if(completed_tasks_count % 3 == 0 && completed_tasks_count < 9):
		generate_next_tasks()
	scene_tasks[completed_tasks_count].visible = true;
		

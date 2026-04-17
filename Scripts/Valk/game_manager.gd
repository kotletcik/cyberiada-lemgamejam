extends Node
class_name GameManager

@export var camera_positions: Array[Vector2];

@export var camera: Camera2D;

var current_level: int;

static var instance: GameManager;

func _ready() -> void:
	if(instance == null):
		instance = self;
	current_level = 0;

func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_1)):
		switch_level(0);
	if(Input.is_key_pressed(KEY_2)):
		switch_level(1);
	if(Input.is_key_pressed(KEY_3)):
		switch_level(2);
	

func switch_level(level: int):
	if(level < 0 || level > 2): return;
	if(current_level == level): return;
	camera.position = camera_positions[level];
	MistakeManager.instance.reset_mistakes_left();
	# TaskManager.instance.generate_next_tasks();
	current_level = level;

func game_completed():
	get_tree().change_scene_to_file("res://scenes/you_won.tscn");

func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn");

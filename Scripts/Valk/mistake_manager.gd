extends Node
class_name MistakeManager

static var instance: MistakeManager;

@export var player: PlayerController;

@export var safe_zone: Node2D;
@export var safe_zone_distance: float;

@export var light_mode: bool;

@export var mistake_timer: float;

var timer: float;

var distance_sqr: float;

var mistakes_left: int; 

func _ready() -> void:
	if(instance == null):
		instance = self;    
		distance_sqr = safe_zone_distance * safe_zone_distance;
		reset_mistakes_left();
	else:
		print("More than one MistakeManager exists!!!");
		queue_free();

func _process(delta: float) -> void:
	timer -= delta;
	if(!Cycle_manager.instance.is_day): return;
	if(player.position.distance_squared_to(safe_zone.position) > distance_sqr):
		var direction: Vector2 = player.position - safe_zone.position;
		player.velocity = -direction * 25;
		player.move_and_slide();
		if(timer < 0):
			register_mistake();
			timer = mistake_timer;
	else: 
		print("in line");

func register_mistake():
	mistakes_left -= 1;
	print(mistakes_left);
	if(mistakes_left < 1):
		get_tree().reload_current_scene();

func reset_mistakes_left():
	mistakes_left = 3;

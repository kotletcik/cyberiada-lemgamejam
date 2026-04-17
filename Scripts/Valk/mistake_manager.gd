extends Node
class_name MistakeManager

static var instance: MistakeManager;

@export var player: PlayerController;

@export var safe_zone: Node2D;
@export var safe_zone_distance: float;

@export var mistake_timer: float;
@export var push_back_timer: float;

var timer: float;
var second_timer: float;

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
	if(player.global_position.distance_squared_to(safe_zone.global_position) > distance_sqr):
		second_timer -= delta;
		if(second_timer < 0):
			var direction: Vector2 = player.global_position - safe_zone.global_position;
			player.velocity = -direction * 25 * 2;
			player.move_and_slide();
			if(timer < 0):
				register_mistake();
				timer = mistake_timer;
			second_timer = push_back_timer;
		#else: 
			#print("in line");

func register_mistake():
	mistakes_left -= 1;
	# print(mistakes_left);
	if(mistakes_left < 1):
		GameManager.instance.game_over();

func reset_mistakes_left():
	mistakes_left = 10;

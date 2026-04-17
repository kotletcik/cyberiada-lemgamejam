extends Node
class_name Aliens_actions_manager

@export var dances: Array[Alien_dance]

@export var aliens: Array[Alien]
var current_aliens_path: Array[Vector2]
var current_dance_name: String
static var instance: Aliens_actions_manager

func _ready():
	if (instance != null):
		print ("more than one aliens actions manager exists")
		instance.queue_free()
	instance = self
	EventBus.step_is_past.connect(give_action_to_aliens)
	EventBus.light_is_switched.connect(change_dance_randomly)
	change_dance_randomly()
	
func give_action_to_aliens():
	for alien in aliens:
		#var alien_target_pos_index = ((alien.id + 1) * current_aliens_path.size() / aliens.size() + (alien.id + 1) * Cycle_manager.instance.current_time_step) % current_aliens_path.size()
		var alien_target_pos_index = ((alien.id + 1) + Cycle_manager.instance.current_time_step) % current_aliens_path.size()
		alien.current_alien_action = Alien_action.new(current_aliens_path[alien_target_pos_index], current_dance_name)
		
		print ("alien target pos index", alien_target_pos_index)
		alien.do_current_action()

func change_dance_randomly():
	var new_dance = dances[randi_range(0, dances.size() - 1)]
	current_aliens_path = new_dance.path
	current_dance_name = new_dance.dance_name

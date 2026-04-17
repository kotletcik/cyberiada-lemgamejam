extends Node
class_name Aliens_actions_manager

@export var dances: Array[Alien_dance]

var aliens: Array[Alien]
var current_aliens_path: Array[Vector2]
var current_dance_name: String
static var instance: Aliens_actions_manager

func _onready():
	if (instance != null):
		print ("more than one aliens actions manager exists")
		instance.queue_free()
		instance = self
	EventBus.step_is_past.connect(give_action_to_aliens)
	
func give_action_to_aliens():
	for alien in aliens:
		var alien_target_pos = alien.id * current_aliens_path.size() / aliens.size() + alien.id * Cycle_manager.instance.current_time_step 
		alien.current_alien_action = Alien_action.new(current_aliens_path[alien_target_pos], current_dance_name)
		alien.do_current_action()

func change_dance_randomly():
	var new_dance = dances[randi_range(0, dances.size() - 1)]
	current_aliens_path = new_dance.path
	current_dance_name = new_dance.dance_name

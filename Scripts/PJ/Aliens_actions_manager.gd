extends Node
class_name Aliens_actions_manager

@export var dances: Array[Alien_dance]

@export var aliens: Array[Alien]
var current_dance: Alien_dance
var current_aliens_path: Array[Node2D]
var current_dance_name: String
var is_static: bool
static var instance: Aliens_actions_manager


func _ready():
	if (instance != null):
		print ("more than one aliens actions manager exists")
		instance.queue_free()
	instance = self
	EventBus.step_is_past.connect(give_action_to_aliens)
	EventBus.light_is_switched.connect(change_dance_to_next)
	await get_tree().process_frame
	change_dance_to_next(true)
	set_first_indexes()
	
func give_action_to_aliens():
	for alien in aliens:
		var alien_target_pos_index
		if (!is_static):
			alien_target_pos_index = (alien.current_target_pos_index + 1)
			if alien_target_pos_index >= current_aliens_path.size():
				alien_target_pos_index = 0
			alien.current_target_pos_index = alien_target_pos_index
		else: alien_target_pos_index = alien.current_target_pos_index
		# alien_target_pos_index = ((alien.id + 1) + Cycle_manager.instance.general_step_counter * int(!is_static)) % current_aliens_path.size()
		#if (Cycle_manager.instance.current_time_step == Cycle_manager.instance.light_steps_count -1):
			#alien_target_pos_index = ((alien.id + 1) + Cycle_manager.instance.general_step_counter * int(!is_static) - 1) % current_aliens_path.size()
		#var alien_target_pos_index = ((alien.id + 1) * current_aliens_path.size() / aliens.size() + (alien.id + 1) * Cycle_manager.instance.current_time_step) % current_aliens_path.size()
		alien.current_alien_action = Alien_action.new(current_aliens_path[alien_target_pos_index].global_position, current_dance_name)
		alien.is_static = is_static
		#if (alien_target_pos_index == current_aliens_path.size() - 1):
		
			
		if (alien_target_pos_index == 0):
			alien.do_current_action_with_teleport()
		else: 
			alien.do_current_action()
		#print ("alien target pos index", alien_target_pos_index)
		alien.do_current_action()

func change_dance_randomly(empty: bool):
	var number = randi_range(0, dances.size() - 1)
	var new_dance = dances[number]
	print (number)
	current_dance = new_dance
	current_aliens_path = new_dance.path
	current_dance_name = new_dance.dance_name
	is_static = new_dance.is_static

func change_dance_to_next(is_day: bool):
	if (is_day):
		var index = (dances.find(current_dance) + 1) % dances.size()
		var new_dance = dances[index]
		print (index)
		current_dance = new_dance
		current_aliens_path = new_dance.path
		current_dance_name = new_dance.dance_name
		is_static = new_dance.is_static
		


func set_first_indexes():
	for alien in aliens:
		var alien_target_pos_index = (alien.id)
		alien.current_target_pos_index = alien_target_pos_index
		# alien_target_pos_index = ((alien.id + 1) + Cycle_manager.instance.general_step_counter * int(!is_static)) % current_aliens_path.size()
		if (Cycle_manager.instance.current_time_step == Cycle_manager.instance.light_steps_count -1):
			alien_target_pos_index = ((alien.id + 1) + Cycle_manager.instance.general_step_counter * int(!is_static) - 1) % current_aliens_path.size()
		#var alien_target_pos_index = ((alien.id + 1) * current_aliens_path.size() / aliens.size() + (alien.id + 1) * Cycle_manager.instance.current_time_step) % current_aliens_path.size()
		alien.current_alien_action = Alien_action.new(current_aliens_path[alien_target_pos_index].global_position, current_dance_name)
		alien.is_static = is_static
		#if (alien_target_pos_index == current_aliens_path.size() - 1):
		
			
		if (alien_target_pos_index == 0):
			alien.do_current_action_with_teleport()
		else: 
			alien.do_current_action()
		#print ("alien target pos index", alien_target_pos_index)
		alien.do_current_action()

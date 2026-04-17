extends CharacterBody2D
class_name Alien

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var current_alien_action: Alien_action
var current_target_pos_index: int
var is_static: bool
#@export var debug_sprite: Sprite2D
@export var id: int
var _delta 

func _physics_process(delta: float) -> void:
	#debug_sprite.global_position = debug_sprite.global_position
	_delta = delta
	move_and_slide()

func do_current_action_with_teleport():
	var direction: Vector2 = (current_alien_action.movement_target_pos - global_position).normalized()
	var distance = (global_position - current_alien_action.movement_target_pos).length()
	var steptime = Cycle_manager.instance.phase_step_duration
	#debug_sprite.global_position = current_alien_action.movement_target_pos
	#print ("current pos: ", global_position)
	#print ("target pos: ", current_alien_action.movement_target_pos)
	#velocity = direction * (distance/steptime) * is_static;
	global_position = current_alien_action.movement_target_pos
	#global_position += direction * (_delta * distance/steptime * 100)
	#print ("delta move: ",(distance))
	if (animated_sprite != null):
		animated_sprite.play(current_alien_action.sprite_name)


func do_current_action():
	var direction: Vector2 = (current_alien_action.movement_target_pos - global_position).normalized()
	var distance = (global_position - current_alien_action.movement_target_pos).length()
	var  steptime = Cycle_manager.instance.phase_step_duration
	#debug_sprite.global_position = current_alien_action.movement_target_pos
	#print ("current pos: ", global_position)
	#print ("target pos: ", current_alien_action.movement_target_pos)
	velocity = direction * (distance/steptime) * int(!is_static);
	#global_position += direction * (_delta * distance/steptime * 100)
	#print ("delta move: ",(distance))
	if (animated_sprite != null):
		animated_sprite.play(current_alien_action.sprite_name)

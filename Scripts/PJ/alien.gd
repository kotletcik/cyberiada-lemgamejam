extends CharacterBody2D
class_name Alien

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var current_alien_action: Alien_action
var speed = 1.0
@export var speed_coeff = 0.01
@export var debug_sprite: Sprite2D
@export var id: int


func _physics_process(delta: float) -> void:
	debug_sprite.global_position = debug_sprite.global_position
	move_and_slide()

func do_current_action():
	var direction = (current_alien_action.movement_target_pos - global_position).normalized
	debug_sprite.global_position = current_alien_action.movement_target_pos
	velocity = speed_coeff * speed * direction;
	animated_sprite.play(current_alien_action.animation)

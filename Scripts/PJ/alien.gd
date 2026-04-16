extends CharacterBody2D
class_name Alien

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var current_alien_action: Alien_action
@export var SPEED = 1.0
var id: int


func _physics_process(delta: float) -> void:
	move_and_slide()

func do_current_action():
	var direction = (current_alien_action.movement_target_pos - global_position).normalized
	velocity = SPEED * direction;
	animated_sprite.play(current_alien_action.animation)

class_name SceneTask
extends Sprite2D

@export var before_state: Texture2D;
@export var after_state: Texture2D;

func _ready():
	texture = before_state;

func complete_task():
	texture = after_state;


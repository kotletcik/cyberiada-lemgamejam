extends Control

@onready var settings: Control = $Settings
@onready var controls: Control = $Controls2

func open_controls() -> void:
	add_child(controls)

func open_settings() -> void:
	add_child(settings)

func _switch() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _exit() -> void:
	get_tree().quit()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	remove_child(settings)
	remove_child(controls)
	get_node("exit").pressed.connect(_exit)
	get_node("dance").pressed.connect(_switch)
	get_node("settings").pressed.connect(open_settings)
	get_node("controls").pressed.connect(open_controls)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(is_inside_tree());

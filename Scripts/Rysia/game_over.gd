extends Control

func _exit() -> void:
	get_tree().quit()
	
func _restart() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	
func go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("restart").pressed.connect(_restart)
	get_node("exit").pressed.connect(_exit)
	get_node("main_menu").pressed.connect(go_to_main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

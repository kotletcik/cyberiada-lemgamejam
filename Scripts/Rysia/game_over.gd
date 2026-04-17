extends Control

func _exit() -> void:
	MenuSoundManager.instance.playButtonClicked()
	get_tree().quit()
	
func _restart() -> void:
	MenuSoundManager.instance.playButtonClicked()
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	
	
func go_to_main_menu() -> void:
	MenuSoundManager.instance.playButtonClicked()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	

func playHoverSound() -> void:
	MenuSoundManager.instance.playButtonHover()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("restart").pressed.connect(_restart)
	get_node("restart").mouse_entered.connect(playHoverSound)
	get_node("exit").pressed.connect(_exit)
	get_node("exit").mouse_entered.connect(playHoverSound)
	get_node("main_menu").pressed.connect(go_to_main_menu)
	get_node("main_menu").mouse_entered.connect(playHoverSound)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

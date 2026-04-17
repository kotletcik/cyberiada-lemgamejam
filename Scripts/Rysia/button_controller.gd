extends Control

@onready var settings: Control = $Settings
@onready var controls: Control = $Controls2

func open_controls() -> void:
	MenuSoundManager.instance.playButtonClicked()
	add_child(controls)
	get_node("Controls2/x").pressed.connect(close_controls)
	

func close_controls() ->void:
	MenuSoundManager.instance.playButtonClicked()
	remove_child(controls)
	
	

func open_settings() -> void:
	MenuSoundManager.instance.playButtonClicked()
	add_child(settings)
	get_node("Settings/x").pressed.connect(close_settings)
	get_node("Settings/x").mouse_entered.connect(playHoverSound)
	

func close_settings() -> void:
	MenuSoundManager.instance.playButtonClicked()
	remove_child(settings)
	
	

func _switch() -> void:
	MenuSoundManager.instance.playButtonClicked()
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	

func _exit() -> void:
	MenuSoundManager.instance.playButtonClicked()
	get_tree().quit()
	

func playHoverSound() -> void:
	MenuSoundManager.instance.playButtonHover()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	remove_child(settings)
	remove_child(controls)
	get_node("exit").pressed.connect(_exit)
	get_node("exit").mouse_entered.connect(playHoverSound)
	get_node("dance").pressed.connect(_switch)
	get_node("dance").mouse_entered.connect(playHoverSound)
	get_node("settings").pressed.connect(open_settings)
	get_node("settings").mouse_entered.connect(playHoverSound)
	get_node("controls").pressed.connect(open_controls)
	get_node("controls").mouse_entered.connect(playHoverSound)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(is_inside_tree());

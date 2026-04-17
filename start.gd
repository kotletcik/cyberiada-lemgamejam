extends TextureButton

func _switch() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_switch)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

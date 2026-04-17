extends Node

class_name MenuSoundManager
static var instance: MenuSoundManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(instance == null):
		instance = self;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func playButtonClicked():
	$ButtonPressSFX.play()

func playButtonHover():
	$ButtonHoverSFX.play()

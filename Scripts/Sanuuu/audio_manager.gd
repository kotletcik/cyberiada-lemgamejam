extends Node

@export var bg_music_player: AudioStreamPlayer
var is_day: bool
@onready var stream: AudioStreamSynchronized

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#is_day = Cycle_manager.instance.is_day
	is_day = false
	stream = bg_music_player.stream
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pass
	#if is_day != true:
		##is_day = Cycle_manager.instance.is_day
	update_music()

func update_music():
	pass

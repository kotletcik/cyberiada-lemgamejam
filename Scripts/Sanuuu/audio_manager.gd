extends Node

class_name SoundManager
static var instance: SoundManager

@export var bg_music_player: AudioStreamPlayer
@export var is_day: bool

var bus_id : int = AudioServer.get_bus_index("Music")
#var sfx_id : int = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#is_day = Cycle_manager.instance.is_day
	is_day = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(is_day)
	if is_day != Cycle_manager.instance.is_day:
		effects_switch(is_day)
		is_day = not is_day

func effects_switch(on: bool):
	if on:
		AudioServer.set_bus_volume_db(bus_id, -10.0)
		for i in range(0,3):
			AudioServer.set_bus_effect_enabled(bus_id, i, true)
	else:
		AudioServer.set_bus_volume_db(bus_id, 0)
		for i in range(0,3):
			AudioServer.set_bus_effect_enabled(bus_id, i, false)

func play_sound_task_done():
	$task_done_sfx.play()

func play_sound_you_win():
	$you_win_sfx.play()

func play_sound_you_lose():
	$you_lose_sfx.play()
	

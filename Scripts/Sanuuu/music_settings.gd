extends Control

var bus_id : int = AudioServer.get_bus_index("Music_main")
var sfx_id : int = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_volume()

func update_volume():
	var music_vol = $MusicScrollBar
	var music_label = $MusicLabel
	var sfx_vol = $SFXScrollBar
	var sfx_label = $SFXLabel
	if music_vol.value == -20.0:
		AudioServer.set_bus_mute(bus_id, true)
	else:
		AudioServer.set_bus_mute(bus_id, false)
		AudioServer.set_bus_volume_db(bus_id, music_vol.value)
	if sfx_vol.value == -20.0:
		AudioServer.set_bus_mute(sfx_id, true)
	else:
		AudioServer.set_bus_mute(sfx_id, false)
		AudioServer.set_bus_volume_db(sfx_id, sfx_vol.value)
	music_label.text = "Music volume: " + str(int((music_vol.value + 20) / 25 * 100)) + "%"
	sfx_label.text = "SFX volume: " + str(int((sfx_vol.value + 20) / 25 * 100)) + "%"

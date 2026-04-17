extends Control

var bus_id : int = AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_volume()

func update_volume():
	var music_vol = $MusicScrollBar
	var music_label = $MusicLabel
	#val value := music_vol.value 
	AudioServer.set_bus_volume_db(bus_id, music_vol.value)
	music_label.text = "Music volume: " + str(int((music_vol.value + 20) / 25 * 100)) + "%"

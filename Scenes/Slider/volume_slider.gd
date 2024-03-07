extends HSlider


@export var bus_name : String

var bus_index : int

func _ready():
	# Get the index
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	# Set the MASTER volume as half so peoples ears wont explode
	if GlobalVar.first_time == true:
		value = 0.5
		GlobalVar.first_time = false
	else:
		value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

# Adjust the volume
func _on_value_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

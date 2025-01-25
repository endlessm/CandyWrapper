extends Control

var master_bus = AudioServer.get_bus_index("Master")
signal audioback

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)

	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_audio_back_button_pressed() -> void:
	audioback.emit()

extends Control

signal back
signal audioback

var master_bus = AudioServer.get_bus_index("Master")
var music = AudioServer.get_bus_index("Music")
var sfx = AudioServer.get_bus_index("Sfx")

@onready var MusicSlider = $Scroll/VBoxContainer/MarginContainer/ExtraWorldsBox/MusicSlider

func _ready() -> void:
	MusicSlider.grab_focus()
	
func _on_back_button_2_pressed() -> void:
	back.emit()


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, value)

	if value == -30:
		AudioServer.set_bus_mute(music, true)
	else:
		AudioServer.set_bus_mute(music, false)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, value)

	if value == -30:
		AudioServer.set_bus_mute(sfx, true)
	else:
		AudioServer.set_bus_mute(sfx, false)


func _on_sfx_slider_visibility_changed() -> void:
	if self.visible and MusicSlider:
		MusicSlider.grab_focus()

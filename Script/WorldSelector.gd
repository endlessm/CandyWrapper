extends Control

@onready var MainWorldSelector = $MainWorldSelector
@onready var ExtraWorldSelector = $ExtraWorldSelector
@onready var SettingsSelector = $SettingsSelector
@onready var AudioSelector = $AudioSelector

func _enter_world(world: String) -> void:
	get_tree().change_scene_to_file(world)


func _on_main_world_selected() -> void:
	_enter_world("res://CandyWrapper/World.tscn")


func _on_extra_worlds_button_pressed() -> void:
	MainWorldSelector.visible = false
	ExtraWorldSelector.visible = true


func _on_back_button_pressed() -> void:
	ExtraWorldSelector.visible = false
	MainWorldSelector.visible = true


func _on_main_world_selector_settings_selected() -> void:
	MainWorldSelector.visible = false
	SettingsSelector.visible = true


func _on_settings_selector_back() -> void:
	SettingsSelector.visible = false
	MainWorldSelector.visible = true

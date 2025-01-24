extends Control

@onready var MainWorldSelector = $MainWorldSelector
@onready var ExtraWorldSelector = $ExtraWorldSelector


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

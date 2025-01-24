extends Node2D

var levels: Array[PackedScene]
var level := 0
const firstLevel := 0
var lastLevel: int

var _level_scene : Level
@onready var _candy_spawner : CandySpawner = $CandySpawner

@onready var NodeAudioWin := $Audio/Win
@onready var NodeAudioLose := $Audio/Lose
@onready var NodeOverlay := $Overlay

## Time to wait after completing a level or dying before switching to the next/previous level
const CHANGE_DELAY := 1.5

## Lists scenes in the given resource directory, accounting for the fact that,
## when exported, resource files are renamed, but must be loaded by their
## original name.
##
## Returns the original basename of each scene in the given directory.
##
## TODO: in Godot 4.4, use ResourceLoader.list_directory()
##  https://docs.godotengine.org/en/latest/classes/class_resourceloader.html#class-resourceloader-method-list-directory
func _list_scenes(path: String) -> Array[String]:
	var scenes: Array[String]
	var dir := DirAccess.open(path)

	dir.list_dir_begin()
	var file := dir.get_next()
	while file:
		if file.ends_with(".tscn.remap"):
			scenes.append(file.left(-len(".remap")))
		elif file.ends_with(".tscn"):
			scenes.append(file)
		file = dir.get_next()
	dir.list_dir_end()

	return scenes

## Load a series of numbered scenes from the given directory.
## Each must be a TileMapLayer node.
func _load_levels(level_directory: String):
	var level_regexp := RegEx.create_from_string("^\\d+\\.tscn$")
	var scenes := _list_scenes(level_directory).filter(func (filename: String): return level_regexp.search(filename))
	scenes.sort_custom(func (a: String, b: String): return a.naturalnocasecmp_to(b) < 0)

	for scene_filename in scenes:
		var l := load(level_directory.path_join(scene_filename)) as PackedScene
		levels.append(l)

	lastLevel = levels.size() - 1

func _ready() -> void:
	_load_levels(self.scene_file_path.get_base_dir())
	_instantiate_level()

func _instantiate_level():
	if _level_scene:
		remove_child(_level_scene)
		_level_scene.queue_free()

	_level_scene = levels[level].instantiate()
	_level_scene.win.connect(_on_win)
	_level_scene.lose.connect(_on_lose)
	_candy_spawner.add_sibling(_level_scene)

	if level == firstLevel:
		NodeOverlay.visible = true
		NodeOverlay.frame = 0
	elif level == lastLevel:
		NodeOverlay.visible = true
		NodeOverlay.frame = 3
	else:
		NodeOverlay.visible = false

	_candy_spawner.progress = float(level - firstLevel) / (lastLevel - firstLevel)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scene/WorldSelector.tscn")

func _process(_delta: float):
	if Input.is_action_just_pressed("jump") and (level == firstLevel or level == lastLevel):
		level = posmod(level + 1, levels.size())
		_instantiate_level()

func _on_win():
	level = posmod(level + 1, levels.size())
	NodeAudioWin.play()
	NodeOverlay.visible = true
	NodeOverlay.frame = 1
	await get_tree().create_timer(CHANGE_DELAY).timeout
	_instantiate_level()

func _on_lose():
	level = max(level - 1, firstLevel)
	NodeAudioLose.play()
	NodeOverlay.visible = true
	NodeOverlay.frame = 2
	await get_tree().create_timer(CHANGE_DELAY).timeout
	_instantiate_level()

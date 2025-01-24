class_name Level
extends Node2D

signal win
signal lose

enum LevelType { NORMAL, TITLE, COMPLETE }
@export var level_type := LevelType.NORMAL

enum {TILE_WALL = 0, TILE_PLAYER = 1, TILE_GOOBER = 2}
@onready var Map: TileMapLayer = $Map

## Any tiles from cell source ID TILE_PLAYER will be replaced by this scene
## when the level runs. It should be an instance of Player.
@export var player_scene := preload("res://Scene/Player.tscn")

## Any tiles from cell source ID TILE_GOOBER will be replaced by this scene
## when the level runs. It should be an instance of Goober.
@export var goober_scene := preload("res://Scene/Goober.tscn")

## This scene is used when the player or a goober is destroyed.
@export var explosion_scene := preload("res://Scene/Explosion.tscn")

@onready var NodeGoobers := $Goobers

var check := false

func _ready():
	if level_type != LevelType.NORMAL:
		var p = player_scene.instantiate()
		p.position = Vector2(72, 85)
		p.scale.x = -1 if randf() < 0.5 else 1
		p.set_script(null)
		add_child(p)

	MapStart()

func MapStart():
	for pos in Map.get_used_cells():
		var id = Map.get_cell_source_id(pos)
		match id:
			TILE_WALL:
				# Use random wall tile from 3×3 tileset to make levels look less repetitive
				var atlas = Vector2(randi_range(0, 2), randi_range(0, 2))
				Map.set_cell(pos, TILE_WALL, atlas)
			TILE_PLAYER:
				# Add live player to the scene
				var inst = player_scene.instantiate()
				inst.position = Map.map_to_local(pos) + Vector2(4, 0)
				self.add_child(inst)
				inst.died.connect(_on_died.bind(inst))
				inst.stomped.connect(_on_stomped)
				# Remove static player tile from the tile map
				Map.set_cell(pos, -1)
			TILE_GOOBER:
				# Add live goober to the scene
				var inst = goober_scene.instantiate()
				inst.position = Map.map_to_local(pos) + Vector2(4, 0)
				NodeGoobers.add_child(inst)
				# Remove static goober tile from the tile map
				Map.set_cell(pos, -1)

func _process(_delta: float):
	# should i check?
	if check:
		check = false
		var count = NodeGoobers.get_child_count()
		print("Goobers: ", count)
		if count == 0:
			win.emit()

func Explode(character: Node2D):
	var xpl = explosion_scene.instantiate()
	xpl.position = character.position
	add_child(xpl)
	character.queue_free()

func _on_died(player: CharacterBody2D):
	Explode(player)
	lose.emit()

func _on_stomped(goober: CharacterBody2D):
	Explode(goober)
	check = true

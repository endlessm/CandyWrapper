## Simulates candy falling from the sky behind the game level. The spawn rate
## increases as the player progresses through the levels; this is controlled
## with [member progress].
class_name CandySpawner
extends Node2D

## The progress of the player through the game, from 0.0 (on the title screen)
## to 1.0 (on the win screen). Candy spawns faster as this value increases.
@export_range(0.0, 1.0) var progress := 0.0:
	set = _set_progress

## The texture to use for the candy falling in the background.
@export var candy_texture: Texture2D = preload("res://Image/Candy.png")

var delay := 3.0
var timer := 0.0


var active := []
var idle := []


func _set_progress(new_progress):
	progress = new_progress

	var old_delay = delay
	if progress >= 1:
		delay = 0.15
	else:
		delay = lerp(3.0, 0.333, progress)

	timer -= (old_delay - delay)


func _process(delta):
	timer -= delta

	for i in active:
		i.position.y += 60.0 * delta
		if i.position.y > 160:
			idle.append(i)

	for i in idle:
		active.erase(i)

	if timer < 0:
		timer = delay
		var c
		if idle.size() > 0:
			c = idle.pop_back()
		else:
			c = Sprite2D.new()
			c.texture = candy_texture
			c.z_index = -1
			add_child(c)
		active.append(c)
		c.position.y = -16
		c.position.x = randi_range(0, 144)

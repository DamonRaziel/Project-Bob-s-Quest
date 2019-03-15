extends Node

func _ready():
	pass

func _process(delta):
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body == self:
			continue
		if body.has_method("process_UI"):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/GameComplete01.tscn")
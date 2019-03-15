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
			if PlayerData.Player_Information.beaten_zombie_boss == false:
				get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level03BossLoading.tscn")
			elif PlayerData.Player_Information.beaten_zombie_boss == true:
				get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")

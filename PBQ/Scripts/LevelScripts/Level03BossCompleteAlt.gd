extends Node

func _ready():
	pass

func _process(delta):
	var area = $AreaAlt
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if body == self:
			continue
		if body.has_method("process_UI"):
			PlayerData.Player_Information.level04unlocked = true
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level8501Loading.tscn")

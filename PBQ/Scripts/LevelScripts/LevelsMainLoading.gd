extends Control

var progress_text
var level_text

func _ready():
	progress_text = $ProgressText
	level_text = $LevelText
	
	if PlayerData.Player_Information.current_level == 1:
		level_text.text = "Level 01: Castle 01"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level01.tscn")
	elif PlayerData.Player_Information.current_level == 2:
		level_text.text = "Level 02: Town 01, Part 01"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level02.tscn")
	elif PlayerData.Player_Information.current_level == 3:
		level_text.text = "Level 03: Town 01, Part 02"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level03.tscn")
	elif PlayerData.Player_Information.current_level == 4:
		level_text.text = "Level 04: Town 02, Part 01"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level04.tscn")
	elif PlayerData.Player_Information.current_level == 5:
		level_text.text = "Level 05: Citadel"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level05.tscn")
	elif PlayerData.Player_Information.current_level == 6:
		level_text.text = "Level 06: Town 02, Part 02"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level06.tscn")
	elif PlayerData.Player_Information.current_level == 7:
		level_text.text = "Level 07: Town 03"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level07.tscn")
	elif PlayerData.Player_Information.current_level == 8:
		level_text.text = "Level 08: Lighthouse"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level08.tscn")
	elif PlayerData.Player_Information.current_level == 9:
		level_text.text = "Level 09: Castle 02"
		get_node("/root/PlayerData").goto_scene_bg("res://Scenes/LevelScenes/Level09.tscn")
	
	elif PlayerData.Player_Information.current_level == 8500:
		level_text.text = "Arena"
		get_node("/root/PlayerData").goto_scene("res://Scenes/ArenaScenes/Arena01Scene.tscn")

func _process(delta):
	progress_text.text = "Loading: " + str(PlayerData.progress)

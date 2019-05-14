extends Control

func _ready():
	pass

func _on_Timer_timeout():
	#get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
	get_node("/root/PlayerData").goto_scene("res://Scenes/CutScenes/Cutscene1Test.tscn")

func _on_Button_pressed():
	#get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
	get_node("/root/PlayerData").goto_scene("res://Scenes/CutScenes/Cutscene1Test.tscn")

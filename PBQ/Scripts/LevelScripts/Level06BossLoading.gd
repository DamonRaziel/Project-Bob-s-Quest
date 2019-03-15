extends Control

func _ready():
	pass

func _on_Timer_timeout():
	get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level06Boss.tscn")






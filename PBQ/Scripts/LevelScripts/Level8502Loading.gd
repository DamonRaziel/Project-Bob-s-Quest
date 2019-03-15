extends Control

func _ready():
	pass

func _on_Timer_timeout():
	get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/SandLevel2.tscn")






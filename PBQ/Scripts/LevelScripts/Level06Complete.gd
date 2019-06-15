extends Node

func _on_Area_body_entered(body):
	if body.has_method("process_UI"):
		if PlayerData.Player_Information.beaten_davey_jones == false:
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level06BossLoading.tscn")
		elif PlayerData.Player_Information.beaten_davey_jones == true:
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")





extends Node

func _on_Area_body_entered(body):
	if body.has_method("process_UI"):
		PlayerData.Player_Information.level04unlocked = true
		get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")







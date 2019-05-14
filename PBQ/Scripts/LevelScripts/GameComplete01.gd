extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#	PlayerData.Game_Data.number_of_times_game_completed += 1
#	if PlayerData.Game_Data.number_of_times_game_completed >= 1:
#		PlayerData.Game_Data.player02_unlocked = true
#		PlayerData.Game_Data.player04_unlocked = true
	if PlayerData.Game_Data.number_of_times_game_completed == 0:
		PlayerData.Game_Data.number_of_times_game_completed += 1
		PlayerData.Game_Data.player02_unlocked = true
		PlayerData.Game_Data.player04_unlocked = true
	elif PlayerData.Game_Data.number_of_times_game_completed == 1:
		PlayerData.Game_Data.number_of_times_game_completed += 1
		PlayerData.Game_Data.player03_unlocked = true
		PlayerData.Game_Data.player06_unlocked = true
		PlayerData.Game_Data.arena_open = true
	elif PlayerData.Game_Data.number_of_times_game_completed >= 2:
		PlayerData.Game_Data.number_of_times_game_completed += 1
	Global_Player.save_game_data()

func _on_Button_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")






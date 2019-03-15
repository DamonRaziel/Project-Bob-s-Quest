extends Node

onready var save01info_name = $Control/SaveFile01/Name
onready var save01info_level = $Control/SaveFile01/Level
onready var save01info_lives = $Control/SaveFile01/Lives
onready var save01info_points = $Control/SaveFile01/Points

onready var save02info_name = $Control/SaveFile02/Name
onready var save02info_level = $Control/SaveFile02/Level
onready var save02info_lives = $Control/SaveFile02/Lives
onready var save02info_points = $Control/SaveFile02/Points

onready var save03info_name = $Control/SaveFile03/Name
onready var save03info_level = $Control/SaveFile03/Level
onready var save03info_lives = $Control/SaveFile03/Lives
onready var save03info_points = $Control/SaveFile03/Points

onready var save04info_name = $Control/SaveFile04/Name
onready var save04info_level = $Control/SaveFile04/Level
onready var save04info_lives = $Control/SaveFile04/Lives
onready var save04info_points = $Control/SaveFile04/Points

func _ready():
	Global_Player.load_info_to_display()
	if Global_Player.save_file_status.file01 == true:
		save01info_name.text = "Name: " + str(Global_Player.save_file01_info.player_name)
		save01info_level.text = "Level: " + str(Global_Player.save_file01_info.current_level)
		save01info_lives.text = "Lives: " + str(Global_Player.save_file01_info.player_lives)
		save01info_points.text = "Points: " + str(Global_Player.save_file01_info.player_points)
	else:
		save01info_name.text = "No"
		save01info_level.text = "File" 
		save01info_lives.text = "To"
		save01info_points.text = "Load"
	if Global_Player.save_file_status.file02 == true:
		save02info_name.text = "Name: " + str(Global_Player.save_file02_info.player_name)
		save02info_level.text = "Level: " + str(Global_Player.save_file02_info.current_level)
		save02info_lives.text = "Lives: " + str(Global_Player.save_file02_info.player_lives)
		save02info_points.text = "Points: " + str(Global_Player.save_file02_info.player_points)
	else:
		save02info_name.text = "No"
		save02info_level.text = "File" 
		save02info_lives.text = "To"
		save02info_points.text = "Load"
	if Global_Player.save_file_status.file03 == true:
		save03info_name.text = "Name: " + str(Global_Player.save_file03_info.player_name)
		save03info_level.text = "Level: " + str(Global_Player.save_file03_info.current_level)
		save03info_lives.text = "Lives: " + str(Global_Player.save_file03_info.player_lives)
		save03info_points.text = "Points: " + str(Global_Player.save_file03_info.player_points)
	else:
		save03info_name.text = "No"
		save03info_level.text = "File" 
		save03info_lives.text = "To"
		save03info_points.text = "Load"
	if Global_Player.save_file_status.file04 == true:
		save04info_name.text = "Name: " + str(Global_Player.save_file04_info.player_name)
		save04info_level.text = "Level: " + str(Global_Player.save_file04_info.current_level)
		save04info_lives.text = "Lives: " + str(Global_Player.save_file04_info.player_lives)
		save04info_points.text = "Points: " + str(Global_Player.save_file04_info.player_points)
	else:
		save04info_name.text = "No"
		save04info_level.text = "File" 
		save04info_lives.text = "To"
		save04info_points.text = "Load"

func _on_LoadButton1_pressed():
	if Global_Player.save_file_status.file01 == true:
		Global_Player.load_file01()
		get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")
	else:
		pass

func _on_LoadButton2_pressed():
	if Global_Player.save_file_status.file02 == true:
		Global_Player.load_file02()
		get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")
	else:
		pass

func _on_LoadButton3_pressed():
	if Global_Player.save_file_status.file03 == true:
		Global_Player.load_file03()
		get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")
	else:
		pass

func _on_LoadButton4_pressed():
	if Global_Player.save_file_status.file04 == true:
		Global_Player.load_file04()
		get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Level00Loading.tscn")
	else:
		pass

func _on_BackButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")

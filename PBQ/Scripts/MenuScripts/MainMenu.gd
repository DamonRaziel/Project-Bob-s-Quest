extends Control

onready var main_screen = get_node("MainMenuTitle")
onready var options_screen = get_node("MainMenuTitle/Options")

var move_menu_left = false
var move_menu_right = false
var menu_move_speed = 30.0
var move_menu_other_left = false
var move_menu_other_right = false

var times_completed_display
var arena_status_display

func _ready():
	#set the mouse to be visible
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	times_completed_display = $GameDataDisplay/TimesCompletedLabel
	arena_status_display = $GameDataDisplay/ArenaOpenLabel

func _process(delta):
	times_completed_display.text = "Times Completed: " + str(PlayerData.Game_Data.number_of_times_game_completed)
	if PlayerData.Game_Data.arena_open == true:
		arena_status_display.text = "Arena: Open"
	elif PlayerData.Game_Data.arena_open == false:
		arena_status_display.text = "Arena: Closed"
	
	if move_menu_left == true:
		main_screen.rect_position.x -= menu_move_speed
	if main_screen.rect_position.x <= -1148:
		move_menu_left = false
	
	if move_menu_right == true:
		main_screen.rect_position.x += menu_move_speed
	if main_screen.rect_position.x >= 832:
		move_menu_right = false
	
	if move_menu_other_left == true:
		main_screen.rect_position.x -= menu_move_speed
	if main_screen.rect_position.x <= 832:
		move_menu_other_left = false
	
	if move_menu_other_right == true:
		main_screen.rect_position.x += menu_move_speed
	if main_screen.rect_position.x >= 2812:
		move_menu_other_right = false
	

func _on_NewGameButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/CharacterSelector.tscn")

func _on_LoadGameButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/LoadScene2d.tscn")

func _on_OptionsButton_pressed():
	move_menu_left = true

func _on_CreditsButton_pressed():
	move_menu_other_right = true

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ArenaButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/ArenaScenes/ArenaSetup.tscn")

func _on_Tutorial_pressed():
	pass # replace with function body

func _on_ScoreBoard_pressed():
	PlayerData.Player_Information.player_name = ""
	PlayerData.Player_Information.player_points = -1
	get_node("/root/PlayerData").goto_scene("res://Scenes/ArenaScenes/ArenaScoreBoard.tscn")

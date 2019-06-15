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

onready var new_game_button = $MainMenuTitle/NewGameButton
onready var load_game_button = $MainMenuTitle/LoadGameButton
onready var arena_button = $MainMenuTitle/ArenaButton
onready var score_board_button = $MainMenuTitle/ScoreBoard
onready var tutorial_button = $MainMenuTitle/Tutorial
onready var options_button = $MainMenuTitle/OptionsButton
onready var credits_button = $MainMenuTitle/CreditsButton
onready var quit_button = $MainMenuTitle/QuitButton

func _ready():
	#set the mouse to be visible
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	times_completed_display = $GameDataDisplay/TimesCompletedLabel
	arena_status_display = $GameDataDisplay/ArenaOpenLabel

func _process(delta):
	if PlayerData.Options_Data.language == "English":
		times_completed_display.text = "Times Completed: " + str(PlayerData.Game_Data.number_of_times_game_completed)
		if PlayerData.Game_Data.arena_open == true:
			arena_status_display.text = "Arena: Open"
		elif PlayerData.Game_Data.arena_open == false:
			arena_status_display.text = "Arena: Closed"
		new_game_button.text = "New Game"
		load_game_button.text = "Load Game"
		arena_button.text = "Arena"
		score_board_button.text = "Arena Scoreboard"
		tutorial_button.text = "Tutorials"
		options_button.text = "Options"
		credits_button.text = "Credits"
		quit_button.text = "Exit"
	elif PlayerData.Options_Data.language == "Spanish":
		times_completed_display.text = "Veces Completado: " + str(PlayerData.Game_Data.number_of_times_game_completed)
		if PlayerData.Game_Data.arena_open == true:
			arena_status_display.text = "Arena: Abierto"
		elif PlayerData.Game_Data.arena_open == false:
			arena_status_display.text = "Arena: Cerrado"
		new_game_button.text = "Nuevo Juego"
		load_game_button.text = "Juego De Carga"
		arena_button.text = "Arena"
		score_board_button.text = "Marcador De Arena"
		tutorial_button.text = "Tutoriales"
		options_button.text = "Opciones"
		credits_button.text = "Creditos"
		quit_button.text = "Salida"
	elif PlayerData.Options_Data.language == "Filipino":
		times_completed_display.text = "Nakumpleto ang mga oras: " + str(PlayerData.Game_Data.number_of_times_game_completed)
		if PlayerData.Game_Data.arena_open == true:
			arena_status_display.text = "Arena: buksan"
		elif PlayerData.Game_Data.arena_open == false:
			arena_status_display.text = "Arena: Sarado"
		new_game_button.text = "Bagong Laro"
		load_game_button.text = "Load Na Laro"
		arena_button.text = "Arena"
		score_board_button.text = "Arena Scoreboard"
		tutorial_button.text = "Tutorial"
		options_button.text = "Mga Pagpipilian"
		credits_button.text = "Kredito"
		quit_button.text = "Lumabas"
	
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
	if PlayerData.Game_Data.arena_open == true:
		get_node("/root/PlayerData").goto_scene("res://Scenes/ArenaScenes/ArenaSetup.tscn")
	else:
		pass

func _on_Tutorial_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/TutorialScenes/TutorialScene.tscn")

func _on_ScoreBoard_pressed():
	PlayerData.Player_Information.player_name = ""
	PlayerData.Player_Information.player_points = -1
	get_node("/root/PlayerData").goto_scene("res://Scenes/ArenaScenes/ArenaScoreBoard.tscn")

extends Control

onready var main_screen = get_node("MainMenuTitle")
onready var options_screen = get_node("MainMenuTitle/Options")

var move_menu_left = false
var move_menu_right = false
var menu_move_speed = 30.0
var move_menu_other_left = false
var move_menu_other_right = false

func _ready():
	#set the mouse to be visible
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	if move_menu_left == true:
		main_screen.rect_position.x -= menu_move_speed
	if main_screen.rect_position.x <= -2048:
		move_menu_left = false
	
	if move_menu_right == true:
		main_screen.rect_position.x += menu_move_speed
	if main_screen.rect_position.x >= -128:
		move_menu_right = false
	
	if move_menu_other_left == true:
		main_screen.rect_position.x -= menu_move_speed
	if main_screen.rect_position.x <= -128:
		move_menu_other_left = false
	
	if move_menu_other_right == true:
		main_screen.rect_position.x += menu_move_speed
	if main_screen.rect_position.x >= 1792:
		move_menu_other_right = false
	

func _on_NewGameButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/CharacterSelector.tscn")

func _on_LoadGameButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/LoadScene2d.tscn")

func _on_OptionsButton_pressed():
	move_menu_left = true

func _on_OptionsBackButton_pressed():
	move_menu_right = true

func _on_CreditsButton_pressed():
	move_menu_other_right = true

func _on_QuitButton_pressed():
	get_tree().quit()

extends Node

var paused = false
var pause_menu
var pause_menu_background

onready var pause_screen = get_node("PauseBG")
onready var options_pause_screen = get_node("PauseBG/Options")

var move_menu_left = false
var move_menu_right = false
var menu_move_speed = 30.0

func _ready():
	paused = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu = $PauseBG
	pause_menu_background = $PauseBackground
	pause_menu.hide()
	pause_menu_background.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if paused == false:
			pause_game()
		elif paused == true:
			unpause_game()
	
	if move_menu_left == true:
		pause_menu.rect_position.x -= menu_move_speed
	if pause_menu.rect_position.x <= -1053:
		move_menu_left = false
	
	if move_menu_right == true:
		pause_menu.rect_position.x += menu_move_speed
	if pause_menu.rect_position.x >= 867:
		move_menu_right = false

func pause_game():
	pause_menu_background.show()
	pause_menu.show()
	paused = true
	get_tree().paused = true
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause_game():
	pause_menu_background.hide()
	pause_menu.hide()
	paused = false
	get_tree().paused = false
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func quit_to_main_menu():
	get_tree().paused = false
	paused = false
	pause_menu_background.hide()
	pause_menu.hide()
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")

func restart_level():
	get_tree().paused = false
	paused = false
	pause_menu_background.hide()
	pause_menu.hide()
	get_parent()._restart_level()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ResumeButton_pressed():
	unpause_game()

func _on_RestartButton_pressed():
	restart_level()

func _on_OptionsButton_pressed():
	move_menu_left = true

func _on_QuitButton_pressed():
	quit_to_main_menu()

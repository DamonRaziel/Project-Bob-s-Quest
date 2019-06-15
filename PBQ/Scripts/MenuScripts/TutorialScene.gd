extends Control

var tutorial_to_show = 1
#1=movement, 2=att, 3=aiming, 4=magic, 5=pickups, 6=inventory, 7=worldmap, 8=shop, 9=saveload, 10=options, 11=unlocks

onready var tutorial_label = $RightSideControl/TutorialRichTextLabel
onready var video_player = $RightSideControl/TutorialVideoPlayer
onready var video_player2 = $RightSideControl/TutorialVideoPlayer2
onready var video_player3 = $RightSideControl/TutorialVideoPlayer3
onready var video_player4 = $RightSideControl/TutorialVideoPlayer4
onready var video_player5 = $RightSideControl/TutorialVideoPlayer5
onready var video_player6 = $RightSideControl/TutorialVideoPlayer6
onready var video_player7 = $RightSideControl/TutorialVideoPlayer7
onready var video_player8 = $RightSideControl/TutorialVideoPlayer8
onready var video_player9 = $RightSideControl/TutorialVideoPlayer9
onready var video_player10 = $RightSideControl/TutorialVideoPlayer10
onready var video_player11 = $RightSideControl/TutorialVideoPlayer11

func _ready():
	tutorial_to_show = 1 # needed??
	video_player.show()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player.play()

func _on_MovementButton_pressed():
	tutorial_to_show = 1
	video_player.show()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player.play()

func _on_AttDefButton_pressed():
	tutorial_to_show = 2
	video_player.hide()
	video_player2.show()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player2.play()

func _on_AimingButton_pressed():
	tutorial_to_show = 3
	video_player.hide()
	video_player2.hide()
	video_player3.show()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player3.play()

func _on_MagicButton_pressed():
	tutorial_to_show = 4
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.show()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player4.play()

func _on_PickupsButton_pressed():
	tutorial_to_show = 5
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.show()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player5.play()

func _on_InventoryButton_pressed():
	tutorial_to_show = 6
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.show()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player6.play()

func _on_WorldButton_pressed():
	tutorial_to_show = 7
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.show()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player7.play()

func _on_ShopButton_pressed():
	tutorial_to_show = 8
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.show()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	video_player8.play()

func _on_SaveGButton_pressed():
	tutorial_to_show = 9
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.show()
	video_player10.hide()
	video_player11.hide()
	video_player9.play()

func _on_LoadGButton_pressed():
	tutorial_to_show = 10
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.show()
	video_player11.hide()
	video_player10.play()

func _on_OptionsButton_pressed():
	tutorial_to_show = 11
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.show()
	video_player11.play()

func _on_ContentButton_pressed():
	tutorial_to_show = 12
	video_player.hide()
	video_player2.hide()
	video_player3.hide()
	video_player4.hide()
	video_player5.hide()
	video_player6.hide()
	video_player7.hide()
	video_player8.hide()
	video_player9.hide()
	video_player10.hide()
	video_player11.hide()
	#video_player5.play()

func _on_BackButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")

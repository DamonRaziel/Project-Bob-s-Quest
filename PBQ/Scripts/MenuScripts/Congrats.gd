extends Label

func _ready():
	#set the mouse to be visible
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_ReturnToMain_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")





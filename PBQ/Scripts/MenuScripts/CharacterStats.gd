extends Control

onready var level_label = $LevelLabel
onready var xp_label = $XPLabel
onready var points_left_label = $StatPointsLeftLabel

onready var strength_label = $StrengthLabel
onready var strength_upgrade_button = $StrengthLabel/StrengthAddButton
onready var strength_upgrades_left_label = $StrengthLabel/PointLimitLeftLabel

onready var speed_label = $SpeedLabel
onready var speed_upgrade_button = $SpeedLabel/SpeedAddButton
onready var speed_upgrades_left_label = $SpeedLabel/PointLimitLeftLabel

onready var jump_label = $JumpLabel
onready var jump_upgrade_button = $JumpLabel/JumpAddButton
onready var jump_upgrades_left_label = $JumpLabel/PointLimitLeftLabel

onready var defence_label = $DefenceLabel
onready var defence_upgrade_button = $DefenceLabel/DefenceAddButton
onready var defence_upgrades_left_label = $DefenceLabel/PointLimitLeftLabel

onready var fire_label = $FireAffinityLabel
onready var fire_upgrade_button = $FireAffinityLabel/FireAddButton
onready var fire_upgrades_left_label = $FireAffinityLabel/PointLimitLeftLabel

onready var ice_label = $IceAffinityLabel
onready var ice_upgrade_button = $IceAffinityLabel/IceAddButton
onready var ice_upgrades_left_label = $IceAffinityLabel/PointLimitLeftLabel

onready var lightning_label = $LightningAffinityLabel
onready var lightning_upgrade_button = $LightningAffinityLabel/LightningAddButton
onready var lightning_upgrades_left_label = $LightningAffinityLabel/PointLimitLeftLabel

onready var earth_label = $EarthAffinityLabel
onready var earth_upgrade_button = $EarthAffinityLabel/EarthAddButton
onready var earth_upgrades_left_label = $EarthAffinityLabel/PointLimitLeftLabel

var paused = false
#var upgrades_menu
#var pause_menu_background
#
#onready var pause_screen = get_node("PauseBG")
#onready var options_pause_screen = get_node("PauseBG/Options")
#
#var move_menu_left = false
#var move_menu_right = false
#var menu_move_speed = 30.0

func _ready():
	level_label.text = "Character Level:   " + str(PlayerData.Player_Information.player_level)
	xp_label.text = "Experience Points:   " + str(PlayerData.Player_Information.player_xp) + "/" + str(PlayerData.Player_Information.player_xp_next_level)
	points_left_label.text = "Upgrade Points:   " + str(PlayerData.Player_Information.player_upgrade_points)
	
	strength_label.text = "Strength:   " + str(PlayerData.Player_Information.player_strength)
	#strength_upgrade_button.text = PlayerData.Player_Information
	strength_upgrades_left_label.text = str(PlayerData.Player_Information.player_strength_upgrades) + "/10"
	
	speed_label.text = "Speed:   " + str(PlayerData.Player_Information.player_speed_max)
	#speed_upgrade_button.text = PlayerData.Player_Information
	speed_upgrades_left_label.text = str(PlayerData.Player_Information.player_speed_upgrades) + "/10"
	
	jump_label.text = "Jump:   " + str(PlayerData.Player_Information.player_jump)
	#jump_upgrade_button.text = PlayerData.Player_Information
	jump_upgrades_left_label.text = str(PlayerData.Player_Information.player_jump_upgrades) + "/10"
	
	defence_label.text = "Defence:   " + str(PlayerData.Player_Information.player_defence)
	#defence_upgrade_button.text = PlayerData.Player_Information
	defence_upgrades_left_label.text = str(PlayerData.Player_Information.player_defence_upgrades) + "/10"
	
	fire_label.text = "Fire Affinity:   " + str(PlayerData.Player_Information.player_fire_affinity)
	#fire_upgrade_button.text = PlayerData.Player_Information
	fire_upgrades_left_label.text = str(PlayerData.Player_Information.player_fire_affinity_upgrades) + "/10"
	
	ice_label.text = "Ice Affinity:   " + str(PlayerData.Player_Information.player_ice_affinity)
	#ice_upgrade_button.text = PlayerData.Player_Information
	ice_upgrades_left_label.text = str(PlayerData.Player_Information.player_ice_affinity_upgrades) + "/10"
	
	lightning_label.text = "Lightning Affinity:   " + str(PlayerData.Player_Information.player_lightning_affinity)
	#lightning_upgrade_button.text = PlayerData.Player_Information
	lightning_upgrades_left_label.text = str(PlayerData.Player_Information.player_lightning_affinity_upgrades) + "/10"
	
	earth_label.text = "Earth Affinity:   " + str(PlayerData.Player_Information.player_earth_affinity)
	#earth_upgrade_button.text = PlayerData.Player_Information
	earth_upgrades_left_label.text = str(PlayerData.Player_Information.player_earth_affinity_upgrades) + "/10"
	
	paused = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	pause_menu = self
#	pause_menu_background = $PauseBackground
	self.hide()
#	pause_menu_background.hide()

#	player_strength = 10,
#	player_speed_max = 6.0,
#	player_speed_accel = 3.0,
#	player_speed_deaccel = 5.0,
#	player_speed_sprint_max = 12.0,
#	player_speed_sprint_accel = 6.0,
#	player_speed_attack_max = 3.0,
#	player_speed_attack_accel = 1.0,
#	player_jump = 5.0,
#
#	player_defence = 1.0,
#	player_fire_affinity = 0.0,
#	player_ice_affinity = 0.0,
#	player_lightning_affinity = 0.0,
#	player_earth_affinity = 0.0,
#
#	player_level = 1,
#	player_xp = 0,
#	player_upgrade_points = 0,
#	player_strength_upgrades = 0,
#	player_speed_upgrades = 0,
#	player_jump_upgrades = 0,
#	player_defence_upgrades = 0,
#	player_fire_affinity_upgrades = 0,
#	player_ice_affinity_upgrades = 0,
#	player_lightning_affinity_upgrades = 0,
#	player_earth_affinity_upgrades = 0,

#func _ready():
#	paused = false
#	get_tree().paused = false
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	pause_menu = $PauseBG
#	pause_menu_background = $PauseBackground
#	pause_menu.hide()
#	pause_menu_background.hide()

func _process(delta):
	if Input.is_action_just_pressed("upgrades"):
		if paused == false:
			pause_game()
		elif paused == true:
			unpause_game()
	
	level_label.text = "Character Level:   " + str(PlayerData.Player_Information.player_level)
	xp_label.text = "Experience Points:   " + str(PlayerData.Player_Information.player_xp) + "/" + str(PlayerData.Player_Information.player_xp_next_level)
	points_left_label.text = "Upgrade Points:   " + str(PlayerData.Player_Information.player_upgrade_points)
	
	strength_label.text = "Strength:   " + str(PlayerData.Player_Information.player_strength)
	#strength_upgrade_button.text = PlayerData.Player_Information
	strength_upgrades_left_label.text = str(PlayerData.Player_Information.player_strength_upgrades) + "/10"
	
	speed_label.text = "Speed:   " + str(PlayerData.Player_Information.player_speed_max)
	#speed_upgrade_button.text = PlayerData.Player_Information
	speed_upgrades_left_label.text = str(PlayerData.Player_Information.player_speed_upgrades) + "/10"
	
	jump_label.text = "Jump:   " + str(PlayerData.Player_Information.player_jump)
	#jump_upgrade_button.text = PlayerData.Player_Information
	jump_upgrades_left_label.text = str(PlayerData.Player_Information.player_jump_upgrades) + "/10"
	
	defence_label.text = "Defence:   " + str(PlayerData.Player_Information.player_defence)
	#defence_upgrade_button.text = PlayerData.Player_Information
	defence_upgrades_left_label.text = str(PlayerData.Player_Information.player_defence_upgrades) + "/10"
	
	fire_label.text = "Fire Affinity:   " + str(PlayerData.Player_Information.player_fire_affinity)
	#fire_upgrade_button.text = PlayerData.Player_Information
	fire_upgrades_left_label.text = str(PlayerData.Player_Information.player_fire_affinity_upgrades) + "/10"
	
	ice_label.text = "Ice Affinity:   " + str(PlayerData.Player_Information.player_ice_affinity)
	#ice_upgrade_button.text = PlayerData.Player_Information
	ice_upgrades_left_label.text = str(PlayerData.Player_Information.player_ice_affinity_upgrades) + "/10"
	
	lightning_label.text = "Lightning Affinity:   " + str(PlayerData.Player_Information.player_lightning_affinity)
	#lightning_upgrade_button.text = PlayerData.Player_Information
	lightning_upgrades_left_label.text = str(PlayerData.Player_Information.player_lightning_affinity_upgrades) + "/10"
	
	earth_label.text = "Earth Affinity:   " + str(PlayerData.Player_Information.player_earth_affinity)
	#earth_upgrade_button.text = PlayerData.Player_Information
	earth_upgrades_left_label.text = str(PlayerData.Player_Information.player_earth_affinity_upgrades) + "/10"
	
	
#	if move_menu_left == true:
#		pause_menu.rect_position.x -= menu_move_speed
#	if pause_menu.rect_position.x <= -1053:
#		move_menu_left = false
#
#	if move_menu_right == true:
#		pause_menu.rect_position.x += menu_move_speed
#	if pause_menu.rect_position.x >= 867:
#		move_menu_right = false

func pause_game():
#	pause_menu_background.show()
	self.show()
	paused = true
	get_tree().paused = true
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause_game():
#	pause_menu_background.hide()
	self.hide()
	paused = false
	get_tree().paused = false
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func quit_to_main_menu():
#	get_tree().paused = false
#	paused = false
#	pause_menu_background.hide()
#	pause_menu.hide()
#	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")
#
#func restart_level():
#	get_tree().paused = false
#	paused = false
#	pause_menu_background.hide()
#	pause_menu.hide()
#	get_parent()._restart_level()
#	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_ResumeButton_pressed():
	unpause_game()

#func _on_RestartButton_pressed():
#	restart_level()
#
#func _on_OptionsButton_pressed():
#	move_menu_left = true
#
#func _on_QuitButton_pressed():
#	quit_to_main_menu()


func _on_StrengthAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_strength_upgrades < 10:
			PlayerData.Player_Information.player_strength += 1
			PlayerData.Player_Information.player_strength_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1
	#pass # replace with function body


func _on_SpeedAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_speed_upgrades < 10:
			PlayerData.Player_Information.player_speed_max += 0.5
			PlayerData.Player_Information.player_speed_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1
	#pass # replace with function body


func _on_JumpAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_jump_upgrades < 10:
			PlayerData.Player_Information.player_jump += 0.5
			PlayerData.Player_Information.player_jump_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1
	#pass # replace with function body


func _on_DefenceAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_defence_upgrades < 10:
			PlayerData.Player_Information.player_defence += 1
			PlayerData.Player_Information.player_defence_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1
	#pass # replace with function body


func _on_FireAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_fire_affiinity_upgrades < 10:
			PlayerData.Player_Information.player_fire_affiinity += 1
			PlayerData.Player_Information.player_fire_affiinity_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1
	#pass # replace with function body


func _on_IceAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_ice_affiinity_upgrades < 10:
			PlayerData.Player_Information.player_ice_affiinity += 1
			PlayerData.Player_Information.player_ice_affiinity_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1


func _on_LightningAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_lightning_affiinity_upgrades < 10:
			PlayerData.Player_Information.player_lightning_affiinity += 1
			PlayerData.Player_Information.player_lightning_affiinity_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1


func _on_EarthAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_earth_affiinity_upgrades < 10:
			PlayerData.Player_Information.player_earth_affiinity += 1
			PlayerData.Player_Information.player_earth_affiinity_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1

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

func _ready():
	set_process(false)
	
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
	self.hide()

func _input(event):
	if Input.is_action_just_pressed("upgrades"):
		if paused == false:
			pause_game()
		elif paused == true:
			unpause_game()

func _process(delta):
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

func pause_game():
	self.show()
	paused = true
	get_tree().paused = true
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_process(true)

func unpause_game():
	self.hide()
	paused = false
	get_tree().paused = false
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process(false)

func _on_ResumeButton_pressed():
	unpause_game()

func _on_StrengthAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_strength_upgrades < 10:
			PlayerData.Player_Information.player_strength += 1
			PlayerData.Player_Information.player_strength_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1

func _on_SpeedAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_speed_upgrades < 10:
			PlayerData.Player_Information.player_speed_max += 0.5
			PlayerData.Player_Information.player_speed_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1

func _on_JumpAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_jump_upgrades < 10:
			PlayerData.Player_Information.player_jump += 0.5
			PlayerData.Player_Information.player_jump_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1

func _on_DefenceAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_defence_upgrades < 10:
			PlayerData.Player_Information.player_defence += 1
			PlayerData.Player_Information.player_defence_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1

func _on_FireAddButton_pressed():
	if PlayerData.Player_Information.player_upgrade_points > 0:
		if PlayerData.Player_Information.player_fire_affiinity_upgrades < 10:
			PlayerData.Player_Information.player_fire_affiinity += 1
			PlayerData.Player_Information.player_fire_affiinity_upgrades += 1
			PlayerData.Player_Information.player_upgrade_points -= 1

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

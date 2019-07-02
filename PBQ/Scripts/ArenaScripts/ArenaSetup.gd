extends Spatial

onready var dif_rect = $SetupHolder/DifficultyLabel/DifficultyRect
onready var e_button = $SetupHolder/DifficultyLabel/EasyButton
onready var n_button = $SetupHolder/DifficultyLabel/NormalButton
onready var h_button = $SetupHolder/DifficultyLabel/HardButton

onready var char_rect = $SetupHolder/CharSelectLabel/CharacterRect
onready var b1_button = $SetupHolder/CharSelectLabel/BobButton
onready var f1_button = $SetupHolder/CharSelectLabel/FrankButton
onready var d1_button = $SetupHolder/CharSelectLabel/DaveButton
onready var b2_button = $SetupHolder/CharSelectLabel/BobbiButton
onready var f2_button = $SetupHolder/CharSelectLabel/FrankieButton
onready var n2_button = $SetupHolder/CharSelectLabel/NengButton

onready var drop_rect = $SetupHolder/DropRateLabel/DropRateRect
onready var l_button = $SetupHolder/DropRateLabel/LowButton
onready var m_button = $SetupHolder/DropRateLabel/MediumButton
onready var hi_button = $SetupHolder/DropRateLabel/HighButton

func _ready():
	#reset inventory and character data here, ready for new inventory and data on selection
	Global_Player.reset_data()
	PlayerData.arena_setup.difficulty = 1
	dif_rect.rect_position.x = e_button.rect_position.x
	dif_rect.rect_position.y = e_button.rect_position.y
	PlayerData.arena_setup.character_selected = 1
	char_rect.rect_position.x = b1_button.rect_position.x
	char_rect.rect_position.y = b1_button.rect_position.y
	PlayerData.arena_setup.drop_rate = 1
	drop_rect.rect_position.x = l_button.rect_position.x
	drop_rect.rect_position.y = l_button.rect_position.y

func _on_EasyButton_pressed():
	PlayerData.arena_setup.difficulty = 1
	dif_rect.rect_position.x = e_button.rect_position.x
	dif_rect.rect_position.y = e_button.rect_position.y

func _on_NormalButton_pressed():
	PlayerData.arena_setup.difficulty = 2
	dif_rect.rect_position.x = n_button.rect_position.x
	dif_rect.rect_position.y = n_button.rect_position.y

func _on_HardButton_pressed():
	PlayerData.arena_setup.difficulty = 3
	dif_rect.rect_position.x = h_button.rect_position.x
	dif_rect.rect_position.y = h_button.rect_position.y

func _on_BobButton_pressed():
	PlayerData.arena_setup.character_selected = 1
	char_rect.rect_position.x = b1_button.rect_position.x
	char_rect.rect_position.y = b1_button.rect_position.y

func _on_FrankButton_pressed():
	PlayerData.arena_setup.character_selected = 2
	char_rect.rect_position.x = f1_button.rect_position.x
	char_rect.rect_position.y = f1_button.rect_position.y

func _on_DaveButton_pressed():
	PlayerData.arena_setup.character_selected = 3
	char_rect.rect_position.x = d1_button.rect_position.x
	char_rect.rect_position.y = d1_button.rect_position.y

func _on_BobbiButton_pressed():
	PlayerData.arena_setup.character_selected = 4
	char_rect.rect_position.x = b2_button.rect_position.x
	char_rect.rect_position.y = b2_button.rect_position.y

func _on_FrankieButton_pressed():
	PlayerData.arena_setup.character_selected = 5
	char_rect.rect_position.x = f2_button.rect_position.x
	char_rect.rect_position.y = f2_button.rect_position.y

func _on_NengButton_pressed():
	PlayerData.arena_setup.character_selected = 6
	char_rect.rect_position.x = n2_button.rect_position.x
	char_rect.rect_position.y = n2_button.rect_position.y

func _on_LowButton_pressed():
	PlayerData.arena_setup.drop_rate = 1
	drop_rect.rect_position.x = l_button.rect_position.x
	drop_rect.rect_position.y = l_button.rect_position.y

func _on_MediumButton_pressed():
	PlayerData.arena_setup.drop_rate = 2
	drop_rect.rect_position.x = m_button.rect_position.x
	drop_rect.rect_position.y = m_button.rect_position.y

func _on_HighButton_pressed():
	PlayerData.arena_setup.drop_rate = 3
	drop_rect.rect_position.x = hi_button.rect_position.x
	drop_rect.rect_position.y = hi_button.rect_position.y

func _on_StartButton_pressed():
	# setup arena variables
	if PlayerData.arena_setup.difficulty == 1:
		PlayerData.Options_Data.difficulty = 0
	elif PlayerData.arena_setup.difficulty == 2:
		PlayerData.Options_Data.difficulty = 1
	elif PlayerData.arena_setup.difficulty == 3:
		PlayerData.Options_Data.difficulty = 2
	
	# setup player arena variables
	#load appropriate info for each player, as character select
	if PlayerData.arena_setup.character_selected == 1:
		PlayerData.Player_Information = {
			player_name = "Bob",
			player_strength = 10,
			player_speed_max = 6.0,
			player_speed_accel = 3.0,
			player_speed_deaccel = 5.0,
			player_speed_sprint_max = 12.0,
			player_speed_sprint_accel = 6.0,
			player_speed_attack_max = 3.0,
			player_speed_attack_accel = 1.0,
			player_jump = 5.0,
			
			player_defence = 1.0,
			player_fire_affinity = 0.0,
			player_ice_affinity = 0.0,
			player_lightning_affinity = 0.0,
			player_earth_affinity = 0.0,
			
			player_level = 1,
			player_max_level = 81,
			player_xp = 0,
			player_xp_next_level = 0,
			player_xp_to_upgrades = 0,
			player_upgrade_points = 0,
			player_max_upgrade_points = 80,
			player_strength_upgrades = 0,
			player_speed_upgrades = 0,
			player_jump_upgrades = 0,
			player_defence_upgrades = 0,
			player_fire_affinity_upgrades = 0,
			player_ice_affinity_upgrades = 0,
			player_lightning_affinity_upgrades = 0,
			player_earth_affinity_upgrades = 0,
			
			#weapons and equipment, allows assigning to slots
			player_current_weapon_number = 1,
			player_current_weapon_slot_number = 1,
			#0=unarmed, 1=sword, 2=lightning sword, 3=axe, 4=ice axe, 
			#5=claymore, 6=fire claymore, 7=warhammer, 8=earth warhammer
			#9=straightbow, 10=recurvebow
			player_current_armour_number = 0,
			#numbers are from Item Database
			player_current_shield_number = 0,
			player_current_helmet_number = 0,
			player_current_item_number = 0,
			
			player_weapon_in_scene = 0,
			player_item_in_scene = 0,
	
			player_inventory_is_full = false,
			
			player_has_flame_burst = false,
			player_has_fireball = false,
			player_has_ice_spike_front = false,
			player_has_ice_spikes_surround = false,
			player_has_quake_spikes = false,
			player_has_crush = false,
			player_has_lightning_throw = false,
			player_has_lightning_surround = false,
			
			player_health = 200, #200
			player_max_health = 200, #200
			player_mana = 150,
			player_max_mana = 150,
			player_lives = 1,
			player_points = 0,
			player_points_bonus = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 8500,
			level01unlocked = true,
			level02unlocked = false,
			level03unlocked = false,
			level04unlocked = false,
			level05unlocked = false,
			level06unlocked = false,
			level07unlocked = false,
			level08unlocked = false,
			level09unlocked = false,
			
			spoken_to_castle_mage = false,
			spoken_to_guard01 = false,
			beaten_zombie_boss = false,
			spoken_to_guard02 = false,
			spoken_to_citadel_mage = false,
			spoken_to_boatman = false,
			beaten_davey_jones = false,
			spoken_to_lighthouse_mage = false,
			beaten_creature_boss = false,
			beaten_sorceror_boss = false
		}
		#weapons and equipment, starts in slots
		Global_Player.inventory_equiped_items = {
			inventory_weapons1 = 1,
			inventory_weapons1_upgrades = 0,
			inventory_weapons2 = -1,
			inventory_weapons2_upgrades = 0,
			inventory_weapons3 = -1,
			inventory_weapons3_upgrades = 0,
			inventory_armour1 = -1,
			inventory_armour1_upgrades = 0,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
			inventory_shield1_upgrades = 0,
			inventory_items1 = -1,
			inventory_items1_amount = -1,
			inventory_items2 = -1,
			inventory_items2_amount = -1,
			inventory_items3 = -1,
			inventory_items3_amount = -1,
			inventory_items4 = -1,
			inventory_items4_amount = -1,
			inventory_items5 = -1,
			inventory_items5_amount = -1,
			inventory_items6 = -1,
			inventory_items6_amount = -1
		}
		
		#Inventory setup, items here are added to the main inventory
		#Global_Player.inventory_addItem(itemID, itemAmount) < general format
		#Global_Player.inventory_addItem(1, 1) # sword < moved to already equiped items
		Global_Player.inventory_addItem(32, 2, 0) # hp large
		Global_Player.inventory_addItem(35, 3, 0) # tea
		#Global_Player.inventory_addItem(38, 2) # torches no need for them here
	
	elif PlayerData.arena_setup.character_selected == 2:
		PlayerData.Player_Information = {
			player_name = "Frank",
			player_strength = 12,
			player_speed_max = 5.0,
			player_speed_accel = 2.5,
			player_speed_deaccel = 4.0,
			player_speed_sprint_max = 10.0,
			player_speed_sprint_accel = 5.0,
			player_speed_attack_max = 2.0,
			player_speed_attack_accel = 1.0,
			player_jump = 5.0,
			
			player_defence = 1.0,
			player_fire_affinity = 0.0,
			player_ice_affinity = 0.0,
			player_lightning_affinity = 0.0,
			player_earth_affinity = 0.0,
			
			player_level = 1,
			player_max_level = 81,
			player_xp = 0,
			player_xp_next_level = 0,
			player_xp_to_upgrades = 0,
			player_upgrade_points = 0,
			player_max_upgrade_points = 80,
			player_strength_upgrades = 0,
			player_speed_upgrades = 0,
			player_jump_upgrades = 0,
			player_defence_upgrades = 0,
			player_fire_affinity_upgrades = 0,
			player_ice_affinity_upgrades = 0,
			player_lightning_affinity_upgrades = 0,
			player_earth_affinity_upgrades = 0,
			
			player_current_weapon_number = 3,
			player_current_weapon_slot_number = 1,
			player_current_armour_number = 0,
			player_current_shield_number = 0,
			player_current_helmet_number = 0,
			player_current_item_number = 0,
			
			player_weapon_in_scene = 0,
			player_item_in_scene = 0,
	
			player_inventory_is_full = false,
			
			player_has_flame_burst = false,
			player_has_fireball = false,
			player_has_ice_spike_front = false,
			player_has_ice_spikes_surround = false,
			player_has_quake_spikes = false,
			player_has_crush = false,
			player_has_lightning_throw = false,
			player_has_lightning_surround = false,
			
			player_health = 250,
			player_max_health = 250, 
			player_mana = 100,
			player_max_mana = 100,
			player_lives = 5,
			player_points = 0,
			player_points_bonus = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 8500,
			level01unlocked = true,
			level02unlocked = false,
			level03unlocked = false,
			level04unlocked = false,
			level05unlocked = false,
			level06unlocked = false,
			level07unlocked = false,
			level08unlocked = false,
			level09unlocked = false,
			
			spoken_to_castle_mage = false,
			spoken_to_guard01 = false,
			beaten_zombie_boss = false,
			spoken_to_guard02 = false,
			spoken_to_citadel_mage = false,
			spoken_to_boatman = false,
			beaten_davey_jones = false,
			spoken_to_lighthouse_mage = false,
			beaten_creature_boss = false,
			beaten_sorceror_boss = false
		}
		Global_Player.inventory_equiped_items = {
			inventory_weapons1 = 3,
			inventory_weapons1_upgrades = 0,
			inventory_weapons2 = -1,
			inventory_weapons2_upgrades = 0,
			inventory_weapons3 = -1,
			inventory_weapons3_upgrades = 0,
			inventory_armour1 = -1,
			inventory_armour1_upgrades = 0,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
			inventory_shield1_upgrades = 0,
			inventory_items1 = -1,
			inventory_items1_amount = -1,
			inventory_items2 = -1,
			inventory_items2_amount = -1,
			inventory_items3 = -1,
			inventory_items3_amount = -1,
			inventory_items4 = -1,
			inventory_items4_amount = -1,
			inventory_items5 = -1,
			inventory_items5_amount = -1,
			inventory_items6 = -1,
			inventory_items6_amount = -1
		}
		
		Global_Player.inventory_addItem(32, 4, 0) # hp high
		Global_Player.inventory_addItem(35, 3, 0) # tea
		#Global_Player.inventory_addItem(38, 2) # torches
		
	elif PlayerData.arena_setup.character_selected == 3:
		PlayerData.Player_Information = {
			player_name = "Dave",
			player_strength = 8,
			player_speed_max = 7.0,
			player_speed_accel = 3.5,
			player_speed_deaccel = 5.0,
			player_speed_sprint_max = 14.0,
			player_speed_sprint_accel = 7.0,
			player_speed_attack_max = 3.0,
			player_speed_attack_accel = 1.0,
			player_jump = 5.0,
			
			player_defence = 1.0,
			player_fire_affinity = 0.0,
			player_ice_affinity = 0.0,
			player_lightning_affinity = 0.0,
			player_earth_affinity = 0.0,
			
			player_level = 1,
			player_max_level = 81,
			player_xp = 0,
			player_xp_next_level = 0,
			player_xp_to_upgrades = 0,
			player_upgrade_points = 0,
			player_max_upgrade_points = 80,
			player_strength_upgrades = 0,
			player_speed_upgrades = 0,
			player_jump_upgrades = 0,
			player_defence_upgrades = 0,
			player_fire_affinity_upgrades = 0,
			player_ice_affinity_upgrades = 0,
			player_lightning_affinity_upgrades = 0,
			player_earth_affinity_upgrades = 0,
			
			player_current_weapon_number = 9,
			player_current_weapon_slot_number = 1,
			player_current_armour_number = 0,
			player_current_shield_number = 0,
			player_current_helmet_number = 0,
			player_current_item_number = 0,
			
			player_weapon_in_scene = 0,
			player_item_in_scene = 0,
	
			player_inventory_is_full = false,
			
			player_has_flame_burst = false,
			player_has_fireball = false,
			player_has_ice_spike_front = false,
			player_has_ice_spikes_surround = false,
			player_has_quake_spikes = false,
			player_has_crush = false,
			player_has_lightning_throw = false,
			player_has_lightning_surround = false,
			
			player_health = 150,
			player_max_health = 150, 
			player_mana = 200,
			player_max_mana = 200,
			player_lives = 5,
			player_points = 0,
			player_points_bonus = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 8500,
			level01unlocked = true,
			level02unlocked = false,
			level03unlocked = false,
			level04unlocked = false,
			level05unlocked = false,
			level06unlocked = false,
			level07unlocked = false,
			level08unlocked = false,
			level09unlocked = false,
			
			spoken_to_castle_mage = false,
			spoken_to_guard01 = false,
			beaten_zombie_boss = false,
			spoken_to_guard02 = false,
			spoken_to_citadel_mage = false,
			spoken_to_boatman = false,
			beaten_davey_jones = false,
			spoken_to_lighthouse_mage = false,
			beaten_creature_boss = false,
			beaten_sorceror_boss = false
		}
		
		Global_Player.inventory_equiped_items = {
			inventory_weapons1 = 9,
			inventory_weapons1_upgrades = 0,
			inventory_weapons2 = -1,
			inventory_weapons2_upgrades = 0,
			inventory_weapons3 = -1,
			inventory_weapons3_upgrades = 0,
			inventory_armour1 = -1,
			inventory_armour1_upgrades = 0,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
			inventory_shield1_upgrades = 0,
			inventory_items1 = -1,
			inventory_items1_amount = -1,
			inventory_items2 = -1,
			inventory_items2_amount = -1,
			inventory_items3 = -1,
			inventory_items3_amount = -1,
			inventory_items4 = -1,
			inventory_items4_amount = -1,
			inventory_items5 = -1,
			inventory_items5_amount = -1,
			inventory_items6 = -1,
			inventory_items6_amount = -1
		}
		
		Global_Player.inventory_addItem(1, 1, 0) # sword
		Global_Player.inventory_addItem(11, 25, 0) #arrows
		Global_Player.inventory_addItem(32, 4, 0) # hp high
		Global_Player.inventory_addItem(35, 3, 0) # tea
		#Global_Player.inventory_addItem(38, 2) # torches
		
	elif PlayerData.arena_setup.character_selected == 4:
		PlayerData.Player_Information = {
			player_name = "Bobbi",
			player_strength = 10,
			player_speed_max = 6.0,
			player_speed_accel = 3.0,
			player_speed_deaccel = 5.0,
			player_speed_sprint_max = 12.0,
			player_speed_sprint_accel = 6.0,
			player_speed_attack_max = 3.0,
			player_speed_attack_accel = 1.0,
			player_jump = 5.0,
			
			player_defence = 1.0,
			player_fire_affinity = 0.0,
			player_ice_affinity = 0.0,
			player_lightning_affinity = 0.0,
			player_earth_affinity = 0.0,
			
			player_level = 1,
			player_max_level = 81,
			player_xp = 0,
			player_xp_next_level = 0,
			player_xp_to_upgrades = 0,
			player_upgrade_points = 0,
			player_max_upgrade_points = 80,
			player_strength_upgrades = 0,
			player_speed_upgrades = 0,
			player_jump_upgrades = 0,
			player_defence_upgrades = 0,
			player_fire_affinity_upgrades = 0,
			player_ice_affinity_upgrades = 0,
			player_lightning_affinity_upgrades = 0,
			player_earth_affinity_upgrades = 0,
			
			player_current_weapon_number = 1,
			player_current_weapon_slot_number = 1,
			player_current_armour_number = 0,
			player_current_shield_number = 0,
			player_current_helmet_number = 0,
			player_current_item_number = 0,
			
			player_weapon_in_scene = 0,
			player_item_in_scene = 0,
	
			player_inventory_is_full = false,
			
			player_has_flame_burst = false,
			player_has_fireball = false,
			player_has_ice_spike_front = false,
			player_has_ice_spikes_surround = false,
			player_has_quake_spikes = false,
			player_has_crush = false,
			player_has_lightning_throw = false,
			player_has_lightning_surround = false,
			
			player_health = 200,
			player_max_health = 200, 
			player_mana = 150,
			player_max_mana = 150,
			player_lives = 5,
			player_points = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 8500,
			level01unlocked = true,
			level02unlocked = false,
			level03unlocked = false,
			level04unlocked = false,
			level05unlocked = false,
			level06unlocked = false,
			level07unlocked = false,
			level08unlocked = false,
			level09unlocked = false,
			
			spoken_to_castle_mage = false,
			spoken_to_guard01 = false,
			beaten_zombie_boss = false,
			spoken_to_guard02 = false,
			spoken_to_citadel_mage = false,
			spoken_to_boatman = false,
			beaten_davey_jones = false,
			spoken_to_lighthouse_mage = false,
			beaten_creature_boss = false,
			beaten_sorceror_boss = false
		}
		
		Global_Player.inventory_equiped_items = {
			inventory_weapons1 = 1,
			inventory_weapons1_upgrades = 0,
			inventory_weapons2 = -1,
			inventory_weapons2_upgrades = 0,
			inventory_weapons3 = -1,
			inventory_weapons3_upgrades = 0,
			inventory_armour1 = -1,
			inventory_armour1_upgrades = 0,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
			inventory_shield1_upgrades = 0,
			inventory_items1 = -1,
			inventory_items1_amount = -1,
			inventory_items2 = -1,
			inventory_items2_amount = -1,
			inventory_items3 = -1,
			inventory_items3_amount = -1,
			inventory_items4 = -1,
			inventory_items4_amount = -1,
			inventory_items5 = -1,
			inventory_items5_amount = -1,
			inventory_items6 = -1,
			inventory_items6_amount = -1
		}
		
		Global_Player.inventory_addItem(32, 2, 0) # hp high
		Global_Player.inventory_addItem(35, 3, 0) # tea
		#Global_Player.inventory_addItem(38, 2) # torches
	
	elif PlayerData.arena_setup.character_selected == 5:
		PlayerData.Player_Information = {
			player_name = "Frankie",
			player_strength = 12,
			player_speed_max = 5.0,
			player_speed_accel = 2.5,
			player_speed_deaccel = 4.0,
			player_speed_sprint_max = 10.0,
			player_speed_sprint_accel = 5.0,
			player_speed_attack_max = 2.0,
			player_speed_attack_accel = 1.0,
			player_jump = 5.0,
			
			player_defence = 1.0,
			player_fire_affinity = 0.0,
			player_ice_affinity = 0.0,
			player_lightning_affinity = 0.0,
			player_earth_affinity = 0.0,
			
			player_level = 1,
			player_max_level = 81,
			player_xp = 0,
			player_xp_next_level = 0,
			player_xp_to_upgrades = 0,
			player_upgrade_points = 0,
			player_max_upgrade_points = 80,
			player_strength_upgrades = 0,
			player_speed_upgrades = 0,
			player_jump_upgrades = 0,
			player_defence_upgrades = 0,
			player_fire_affinity_upgrades = 0,
			player_ice_affinity_upgrades = 0,
			player_lightning_affinity_upgrades = 0,
			player_earth_affinity_upgrades = 0,
			
			player_current_weapon_number = 3,
			player_current_weapon_slot_number = 1,
			player_current_armour_number = 0,
			player_current_shield_number = 0,
			player_current_helmet_number = 0,
			player_current_item_number = 0,
			
			player_weapon_in_scene = 0,
			player_item_in_scene = 0,
	
			player_inventory_is_full = false,
			
			player_has_flame_burst = false,
			player_has_fireball = false,
			player_has_ice_spike_front = false,
			player_has_ice_spikes_surround = false,
			player_has_quake_spikes = false,
			player_has_crush = false,
			player_has_lightning_throw = false,
			player_has_lightning_surround = false,
			
			player_health = 250,
			player_max_health = 250, 
			player_mana = 100,
			player_max_mana = 100,
			player_lives = 5,
			player_points = 0,
			player_points_bonus = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 8500,
			level01unlocked = true,
			level02unlocked = false,
			level03unlocked = false,
			level04unlocked = false,
			level05unlocked = false,
			level06unlocked = false,
			level07unlocked = false,
			level08unlocked = false,
			level09unlocked = false,
			
			spoken_to_castle_mage = false,
			spoken_to_guard01 = false,
			beaten_zombie_boss = false,
			spoken_to_guard02 = false,
			spoken_to_citadel_mage = false,
			spoken_to_boatman = false,
			beaten_davey_jones = false,
			spoken_to_lighthouse_mage = false,
			beaten_creature_boss = false,
			beaten_sorceror_boss = false
		}
		
		Global_Player.inventory_equiped_items = {
			inventory_weapons1 = 3,
			inventory_weapons1_upgrades = 0,
			inventory_weapons2 = -1,
			inventory_weapons2_upgrades = 0,
			inventory_weapons3 = -1,
			inventory_weapons3_upgrades = 0,
			inventory_armour1 = -1,
			inventory_armour1_upgrades = 0,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
			inventory_shield1_upgrades = 0,
			inventory_items1 = -1,
			inventory_items1_amount = -1,
			inventory_items2 = -1,
			inventory_items2_amount = -1,
			inventory_items3 = -1,
			inventory_items3_amount = -1,
			inventory_items4 = -1,
			inventory_items4_amount = -1,
			inventory_items5 = -1,
			inventory_items5_amount = -1,
			inventory_items6 = -1,
			inventory_items6_amount = -1
		}
		
		Global_Player.inventory_addItem(31, 4, 0) # hp low
		Global_Player.inventory_addItem(35, 3, 0) # tea
		#Global_Player.inventory_addItem(38, 2) # torches
		
	elif PlayerData.arena_setup.character_selected == 6:
		PlayerData.Player_Information = {
			player_name = "Neng",
			player_strength = 8,
			player_speed_max = 7.0,
			player_speed_accel = 3.5,
			player_speed_deaccel = 5.0,
			player_speed_sprint_max = 14.0,
			player_speed_sprint_accel = 7.0,
			player_speed_attack_max = 3.0,
			player_speed_attack_accel = 1.0,
			player_jump = 5.0,
			
			player_defence = 1.0,
			player_fire_affinity = 0.0,
			player_ice_affinity = 0.0,
			player_lightning_affinity = 0.0,
			player_earth_affinity = 0.0,
			
			player_level = 1,
			player_max_level = 81,
			player_xp = 0,
			player_xp_next_level = 0,
			player_xp_to_upgrades = 0,
			player_upgrade_points = 0,
			player_max_upgrade_points = 80,
			player_strength_upgrades = 0,
			player_speed_upgrades = 0,
			player_jump_upgrades = 0,
			player_defence_upgrades = 0,
			player_fire_affinity_upgrades = 0,
			player_ice_affinity_upgrades = 0,
			player_lightning_affinity_upgrades = 0,
			player_earth_affinity_upgrades = 0,
			
			player_current_weapon_number = 9,
			player_current_weapon_slot_number = 1,
			player_current_armour_number = 0,
			player_current_shield_number = 0,
			player_current_helmet_number = 0,
			player_current_item_number = 0,
			
			player_weapon_in_scene = 0,
			player_item_in_scene = 0,
	
			player_inventory_is_full = false,
			
			player_has_flame_burst = false,
			player_has_fireball = false,
			player_has_ice_spike_front = false,
			player_has_ice_spikes_surround = false,
			player_has_quake_spikes = false,
			player_has_crush = false,
			player_has_lightning_throw = false,
			player_has_lightning_surround = false,
			
			player_health = 150,
			player_max_health = 150, 
			player_mana = 200,
			player_max_mana = 200,
			player_lives = 5,
			player_points = 0,
			player_points_bonus = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 8500,
			level01unlocked = true,
			level02unlocked = false,
			level03unlocked = false,
			level04unlocked = false,
			level05unlocked = false,
			level06unlocked = false,
			level07unlocked = false,
			level08unlocked = false,
			level09unlocked = false,
			
			spoken_to_castle_mage = false,
			spoken_to_guard01 = false,
			beaten_zombie_boss = false,
			spoken_to_guard02 = false,
			spoken_to_citadel_mage = false,
			spoken_to_boatman = false,
			beaten_davey_jones = false,
			spoken_to_lighthouse_mage = false,
			beaten_creature_boss = false,
			beaten_sorceror_boss = false
		}
		
		Global_Player.inventory_equiped_items = {
			inventory_weapons1 = 9,
			inventory_weapons1_upgrades = 0,
			inventory_weapons2 = -1,
			inventory_weapons2_upgrades = 0,
			inventory_weapons3 = -1,
			inventory_weapons3_upgrades = 0,
			inventory_armour1 = -1,
			inventory_armour1_upgrades = 0,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
			inventory_shield1_upgrades = 0,
			inventory_items1 = -1,
			inventory_items1_amount = -1,
			inventory_items2 = -1,
			inventory_items2_amount = -1,
			inventory_items3 = -1,
			inventory_items3_amount = -1,
			inventory_items4 = -1,
			inventory_items4_amount = -1,
			inventory_items5 = -1,
			inventory_items5_amount = -1,
			inventory_items6 = -1,
			inventory_items6_amount = -1
		}
		
		Global_Player.inventory_addItem(1, 1, 0) # sword
		Global_Player.inventory_addItem(11, 25, 0) #arrows
		Global_Player.inventory_addItem(32, 4, 0) # hp high
		Global_Player.inventory_addItem(35, 3, 0) # tea
		#Global_Player.inventory_addItem(38, 2) # torches
		
	# goto the loading scene 
	get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")

func _on_BackButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")

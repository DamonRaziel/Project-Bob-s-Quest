extends Spatial
# adapted from rotating character select demo

var character_name_number = 1
var character_name_display
var character_info = ""
var cam_holder
var cam_angle = 0.0
var cam_pos1 = 0
var cam_pos2 = 45

var select_time = 0.0
var select_timer = 3.0

#Max characters
var number_of_characters = 6
#current character
#var current_character;
# The current angle
var current_angle = Vector3();
#Which angle to rotate
var target_rotation = Vector3();
export var speed = 3.0;
var select_button
var left_button
var right_button
var locked_label

func _ready():
	select_button = $CharacterSelectTitle/SelectButton
	left_button = $CharacterSelectTitle/LeftButton
	right_button = $CharacterSelectTitle/RightButton
	locked_label = $CharacterSelectTitle/LockedLabel
	#set the vars to their nodes
	character_name_display = $CharacterSelectTitle/CharName
	character_info = $CharacterSelectTitle/Info
	character_name_number = 1
	#current_character = 2;
	cam_angle = 0.0
	#reset inventory and character data here, ready for new inventory and data on selection
	Global_Player.reset_data()
	#set the mouse to be visible, just to make sure
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	rotation_degrees = Vector3(0,lerp(rotation_degrees.y,target_rotation.y,speed*delta),0);
	
	if character_name_number == 1:
		left_button.hide()
		right_button.show()
		if PlayerData.Game_Data.player01_unlocked == true:
			select_button.show()
			locked_label.hide()
		elif PlayerData.Game_Data.player01_unlocked == false:
			select_button.hide()
			locked_label.show()
		character_name_display.text = "Bob"
		character_info.text = "Start Gear:" + "\n"
		character_info.text = character_info.text + "Sword (x1)\n"
		character_info.text = character_info.text + "Small hp potion (x2)\n"
		character_info.text = character_info.text + "Tea (x3)\n"
		character_info.text = character_info.text + "Torches (x2)\n"
		character_info.text = character_info.text + "\n"
		character_info.text = character_info.text + "Stats:" + "\n"
		character_info.text = character_info.text + "STR: 10 \n"
		character_info.text = character_info.text + "SPEED: 6 \n"
		character_info.text = character_info.text + "JUMP: 5 \n"
		character_info.text = character_info.text + "HP: 200 \n"
		character_info.text = character_info.text + "MANA: 150 \n"
	elif character_name_number == 2:
		left_button.show()
		right_button.show()
		if PlayerData.Game_Data.player02_unlocked == true:
			select_button.show()
			locked_label.hide()
		elif PlayerData.Game_Data.player02_unlocked == false:
			select_button.hide()
			locked_label.show()
		character_name_display.text = "Frank"
		character_info.text = "Start Gear:" + "\n"
		character_info.text = character_info.text + "Axe (x1)\n"
		character_info.text = character_info.text + "Small hp potion (x2)\n"
		character_info.text = character_info.text + "Tea (x3)\n"
		character_info.text = character_info.text + "Torches (x2)\n"
		character_info.text = character_info.text + "\n"
		character_info.text = character_info.text + "Stats:" + "\n"
		character_info.text = character_info.text + "STR: 12 \n"
		character_info.text = character_info.text + "SPEED: 5 \n"
		character_info.text = character_info.text + "JUMP: 5 \n"
		character_info.text = character_info.text + "HP: 240 \n"
		character_info.text = character_info.text + "MANA: 110 \n"
	elif character_name_number == 3:
		left_button.show()
		right_button.show()
		if PlayerData.Game_Data.player03_unlocked == true:
			select_button.show()
			locked_label.hide()
		elif PlayerData.Game_Data.player03_unlocked == false:
			select_button.hide()
			locked_label.show()
		character_name_display.text = "Dave"
		character_info.text = "Start Gear:" + "\n"
		character_info.text = character_info.text + "Bow (x1)\n"
		character_info.text = character_info.text + "Small hp potion (x2)\n"
		character_info.text = character_info.text + "Tea (x3)\n"
		character_info.text = character_info.text + "Torches (x2)\n"
		character_info.text = character_info.text + "\n"
		character_info.text = character_info.text + "Stats:" + "\n"
		character_info.text = character_info.text + "STR: 8 \n"
		character_info.text = character_info.text + "SPEED: 7 \n"
		character_info.text = character_info.text + "JUMP: 5 \n"
		character_info.text = character_info.text + "HP: 150 \n"
		character_info.text = character_info.text + "MANA: 200 \n"
	elif character_name_number == 4:
		left_button.show()
		right_button.show()
		if PlayerData.Game_Data.player04_unlocked == true:
			select_button.show()
			locked_label.hide()
		elif PlayerData.Game_Data.player04_unlocked == false:
			select_button.hide()
			locked_label.show()
		character_name_display.text = "Bobbi"
		character_info.text = "Start Gear:" + "\n"
		character_info.text = character_info.text + "Sword (x1)\n"
		character_info.text = character_info.text + "Small hp potion (x2)\n"
		character_info.text = character_info.text + "Tea (x3)\n"
		character_info.text = character_info.text + "Torches (x2)\n"
		character_info.text = character_info.text + "\n"
		character_info.text = character_info.text + "Stats:" + "\n"
		character_info.text = character_info.text + "STR: 10 \n"
		character_info.text = character_info.text + "SPEED: 6 \n"
		character_info.text = character_info.text + "JUMP: 5 \n"
		character_info.text = character_info.text + "HP: 200 \n"
		character_info.text = character_info.text + "MANA: 150 \n"
	elif character_name_number == 5:
		left_button.show()
		right_button.show()
		if PlayerData.Game_Data.player05_unlocked == true:
			select_button.show()
			locked_label.hide()
		elif PlayerData.Game_Data.player05_unlocked == false:
			select_button.hide()
			locked_label.show()
		character_name_display.text = "Frankie"
		character_info.text = "Start Gear:" + "\n"
		character_info.text = character_info.text + "Axe (x1)\n"
		character_info.text = character_info.text + "Small hp potion (x2)\n"
		character_info.text = character_info.text + "Tea (x3)\n"
		character_info.text = character_info.text + "Torches (x2)\n"
		character_info.text = character_info.text + "\n"
		character_info.text = character_info.text + "Stats:" + "\n"
		character_info.text = character_info.text + "STR: 12 \n"
		character_info.text = character_info.text + "SPEED: 5 \n"
		character_info.text = character_info.text + "JUMP: 5 \n"
		character_info.text = character_info.text + "HP: 240 \n"
		character_info.text = character_info.text + "MANA: 110 \n"
	elif character_name_number == 6:
		left_button.show()
		right_button.hide()
		if PlayerData.Game_Data.player02_unlocked == true:
			select_button.show()
			locked_label.hide()
		elif PlayerData.Game_Data.player02_unlocked == false:
			select_button.hide()
			locked_label.show()
		character_name_display.text = "Neng"
		character_info.text = "Start Gear:" + "\n"
		character_info.text = character_info.text + "Bow (x1)\n"
		character_info.text = character_info.text + "Small hp potion (x2)\n"
		character_info.text = character_info.text + "Tea (x3)\n"
		character_info.text = character_info.text + "Torches (x2)\n"
		character_info.text = character_info.text + "\n"
		character_info.text = character_info.text + "Stats:" + "\n"
		character_info.text = character_info.text + "STR: 8 \n"
		character_info.text = character_info.text + "SPEED: 7 \n"
		character_info.text = character_info.text + "JUMP: 5 \n"
		character_info.text = character_info.text + "HP: 150 \n"
		character_info.text = character_info.text + "MANA: 200 \n"

func _on_LeftButton_pressed():
	if character_name_number>1:
		target_rotation = target_rotation -  Vector3(0,45,0)
		character_name_number-=1

func _on_RightButton_pressed():
	if character_name_number<number_of_characters:
		target_rotation = target_rotation + Vector3(0,45,0)
		character_name_number+=1

func _on_SelectButton_pressed():
	#load appropriate info for each player
	if character_name_number == 1:
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
			
			player_health = 200,
			player_max_health = 200, 
			player_mana = 150,
			player_max_mana = 150,
			player_lives = 5,
			player_points = 0,
			player_points_bonus = 0,
			player_coins = 0,
			
			shards_collected = 0,
			
			current_level = 1,
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
			inventory_weapons2 = -1,
			inventory_weapons3 = -1,
			inventory_armour1 = -1,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
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
		Global_Player.inventory_addItem(32, 2) # hp large
		Global_Player.inventory_addItem(35, 3) # tea
		Global_Player.inventory_addItem(38, 2) # torches
	
	elif character_name_number == 2:
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
			
			current_level = 1,
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
			inventory_weapons2 = -1,
			inventory_weapons3 = -1,
			inventory_armour1 = -1,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
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
		
		Global_Player.inventory_addItem(32, 4) # hp high
		Global_Player.inventory_addItem(35, 3) # tea
		Global_Player.inventory_addItem(38, 2) # torches
		
	elif character_name_number == 3:
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
			
			current_level = 1,
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
			inventory_weapons2 = -1,
			inventory_weapons3 = -1,
			inventory_armour1 = -1,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
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
		
		Global_Player.inventory_addItem(1, 1) # sword
		Global_Player.inventory_addItem(11, 25) #arrows
		Global_Player.inventory_addItem(32, 4) # hp high
		Global_Player.inventory_addItem(35, 3) # tea
		Global_Player.inventory_addItem(38, 2) # torches
		
	elif character_name_number == 4:
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
			
			current_level = 1,
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
			inventory_weapons2 = -1,
			inventory_weapons3 = -1,
			inventory_armour1 = -1,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
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
		
		Global_Player.inventory_addItem(32, 2) # hp high
		Global_Player.inventory_addItem(35, 3) # tea
		Global_Player.inventory_addItem(38, 2) # torches
	
	elif character_name_number == 5:
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
			
			current_level = 1,
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
			inventory_weapons2 = -1,
			inventory_weapons3 = -1,
			inventory_armour1 = -1,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
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
		
		Global_Player.inventory_addItem(31, 4) # hp low
		Global_Player.inventory_addItem(35, 3) # tea
		Global_Player.inventory_addItem(38, 2) # torches
		
	elif character_name_number == 6:
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
			
			current_level = 1,
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
			inventory_weapons2 = -1,
			inventory_weapons3 = -1,
			inventory_armour1 = -1,
			inventory_helmet1 = -1,
			inventory_shield1 = -1,
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
		
		Global_Player.inventory_addItem(1, 1) # sword
		Global_Player.inventory_addItem(11, 25) #arrows
		Global_Player.inventory_addItem(32, 4) # hp high
		Global_Player.inventory_addItem(35, 3) # tea
		Global_Player.inventory_addItem(38, 2) # torches
		
	get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/Intro.tscn")

func _on_BackButton_pressed():
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")

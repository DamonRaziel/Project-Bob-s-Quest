extends Spatial

var drop_navmesh
var drop_target
var drop_waypoint_numbers_to_choose_from
var drop_waypoint_number_chosen
var drop_enemy_waypoints

var sword_drop = preload("res://Scenes/PickupScenes/PickupWeaponSword.tscn")
var lightning_sword_drop = preload("res://Scenes/PickupScenes/PickupWeaponSwordLightning.tscn")
var axe_drop = preload("res://Scenes/PickupScenes/PickupWeaponAxe.tscn")
var ice_axe_drop = preload("res://Scenes/PickupScenes/PickupWeaponAxeIce.tscn")
var claymore_drop = preload("res://Scenes/PickupScenes/PickupWeaponClaymore.tscn")
var fire_claymore_drop = preload("res://Scenes/PickupScenes/PickupWeaponClaymoreFire.tscn")
var warhammer_drop = preload("res://Scenes/PickupScenes/PickupWeaponWarhammer.tscn")
var earth_warhammer_drop = preload("res://Scenes/PickupScenes/PickupWeaponWarhammerEarth.tscn")
var straight_bow_drop = preload("res://Scenes/PickupScenes/PickupWeaponBowStraight.tscn")
var recurve_bow_drop = preload("res://Scenes/PickupScenes/PickupWeaponBowRecurve.tscn")
var arrow_drop = preload("res://Scenes/PickupScenes/PickupArrowsNormal.tscn")
#need to create an extra arrows pickup for individual arrows dropped
var chainmail_drop = preload("res://Scenes/PickupScenes/PickupArmourChainmail.tscn")
var scalemail_drop = preload("res://Scenes/PickupScenes/PickupArmourScalemail.tscn")
var fullplate_drop = preload("res://Scenes/PickupScenes/PickupArmourFullPlate.tscn")

var buckler_shield_drop = preload("res://Scenes/PickupScenes/PickupShieldBuckler.tscn")
var small_shield_drop = preload("res://Scenes/PickupScenes/PickupShieldSmall.tscn")
var medium_shield_drop = preload("res://Scenes/PickupScenes/PickupShieldMedium.tscn")
var tower_shield_drop = preload("res://Scenes/PickupScenes/PickupShieldTower.tscn")

var green_apple_drop = preload("res://Scenes/PickupScenes/PickupAppleGreen.tscn")
var red_apple_drop = preload("res://Scenes/PickupScenes/PickupAppleRed.tscn")
var health_potion_drop = preload("res://Scenes/PickupScenes/PickupPotionHealth.tscn")
var mana_potion_drop = preload("res://Scenes/PickupScenes/PickupPotionMana.tscn")
var strength_potion_drop = preload("res://Scenes/PickupScenes/PickupPotionStrength.tscn")
var speed_potion_drop = preload("res://Scenes/PickupScenes/PickupPotionSpeed.tscn")
var fortitude_potion_drop = preload("res://Scenes/PickupScenes/PickupPotionFortitute.tscn")
var tea_drop = preload("res://Scenes/PickupScenes/PickupTea.tscn")

var drop_choice_number
var drop_choice
var drop_clone

func _ready():
	drop_navmesh = get_parent()
	drop_enemy_waypoints = drop_navmesh.get_node("WaypointsHolder").waypoints
	drop_waypoint_numbers_to_choose_from = drop_navmesh.get_node("WaypointsHolder").waypoints_number

func spawn_drop():
	randomize()
	drop_waypoint_number_chosen = randi()%drop_waypoint_numbers_to_choose_from
	drop_target = drop_enemy_waypoints[drop_waypoint_number_chosen]
	drop_choice_number = randi()%52
	#print ("drop number chosen = ", drop_choice_number)
	#weapons, armours, shields (17, 1 each)
	if drop_choice_number == 0:
		drop_clone = sword_drop.instance()
	elif drop_choice_number == 1:
		drop_clone = lightning_sword_drop.instance()
	elif drop_choice_number == 2:
		drop_clone = axe_drop.instance()
	elif drop_choice_number == 3:
		drop_clone = ice_axe_drop.instance()
	elif drop_choice_number == 4:
		drop_clone = claymore_drop.instance()
	elif drop_choice_number == 5:
		drop_clone = fire_claymore_drop.instance()
	elif drop_choice_number == 6:
		drop_clone = warhammer_drop.instance()
	elif drop_choice_number == 7:
		drop_clone = earth_warhammer_drop.instance()
	elif drop_choice_number == 8:
		drop_clone = straight_bow_drop.instance()
	elif drop_choice_number == 9:
		drop_clone = recurve_bow_drop.instance()
	elif drop_choice_number == 10:
		drop_clone = chainmail_drop.instance()
	elif drop_choice_number == 11:
		drop_clone = scalemail_drop.instance()
	elif drop_choice_number == 12:
		drop_clone = fullplate_drop.instance()
	elif drop_choice_number == 13:
		drop_clone = buckler_shield_drop.instance()
	elif drop_choice_number == 14:
		drop_clone = small_shield_drop.instance()
	elif drop_choice_number == 15:
		drop_clone = medium_shield_drop.instance()
	elif drop_choice_number == 16:
		drop_clone = tower_shield_drop.instance()
	#arrows, and consumables (36, 4 each)
	elif drop_choice_number == 17:
		drop_clone = arrow_drop.instance()
	elif drop_choice_number == 18:
		drop_clone = arrow_drop.instance()
	elif drop_choice_number == 19:
		drop_clone = arrow_drop.instance()
	elif drop_choice_number == 20:
		drop_clone = arrow_drop.instance()
	elif drop_choice_number == 21:
		drop_clone = green_apple_drop.instance()
	elif drop_choice_number == 22:
		drop_clone = green_apple_drop.instance()
	elif drop_choice_number == 23:
		drop_clone = green_apple_drop.instance()
	elif drop_choice_number == 24:
		drop_clone = green_apple_drop.instance()
	elif drop_choice_number == 25:
		drop_clone = red_apple_drop.instance()
	elif drop_choice_number == 26:
		drop_clone = red_apple_drop.instance()
	elif drop_choice_number == 27:
		drop_clone = red_apple_drop.instance()
	elif drop_choice_number == 28:
		drop_clone = red_apple_drop.instance()
	elif drop_choice_number == 29:
		drop_clone = health_potion_drop.instance()
	elif drop_choice_number == 30:
		drop_clone = health_potion_drop.instance()
	elif drop_choice_number == 31:
		drop_clone = health_potion_drop.instance()
	elif drop_choice_number == 32:
		drop_clone = health_potion_drop.instance()
	elif drop_choice_number == 33:
		drop_clone = mana_potion_drop.instance()
	elif drop_choice_number == 34:
		drop_clone = mana_potion_drop.instance()
	elif drop_choice_number == 35:
		drop_clone = mana_potion_drop.instance()
	elif drop_choice_number == 36:
		drop_clone = mana_potion_drop.instance()
	elif drop_choice_number == 37:
		drop_clone = strength_potion_drop.instance()
	elif drop_choice_number == 38:
		drop_clone = strength_potion_drop.instance()
	elif drop_choice_number == 39:
		drop_clone = strength_potion_drop.instance()
	elif drop_choice_number == 40:
		drop_clone = strength_potion_drop.instance()
	elif drop_choice_number == 41:
		drop_clone = speed_potion_drop.instance()
	elif drop_choice_number == 42:
		drop_clone = speed_potion_drop.instance()
	elif drop_choice_number == 43:
		drop_clone = speed_potion_drop.instance()
	elif drop_choice_number == 44:
		drop_clone = speed_potion_drop.instance()
	elif drop_choice_number == 45:
		drop_clone = fortitude_potion_drop.instance()
	elif drop_choice_number == 46:
		drop_clone = fortitude_potion_drop.instance()
	elif drop_choice_number == 47:
		drop_clone = fortitude_potion_drop.instance()
	elif drop_choice_number == 48:
		drop_clone = fortitude_potion_drop.instance()
	elif drop_choice_number == 49:
		drop_clone = tea_drop.instance()
	elif drop_choice_number == 50:
		drop_clone = tea_drop.instance()
	elif drop_choice_number == 51:
		drop_clone = tea_drop.instance()
	elif drop_choice_number == 52:
		drop_clone = tea_drop.instance()
	self.add_child(drop_clone) 
	drop_clone.global_transform.origin.x = drop_target.global_transform.origin.x
	drop_clone.global_transform.origin.z = drop_target.global_transform.origin.z
	drop_clone.global_transform.origin.y = drop_target.global_transform.origin.y

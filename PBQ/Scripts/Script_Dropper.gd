extends Spatial

#add in preloads for all items
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
var torch_drop = preload("res://Scenes/PickupScenes/PickupTorches.tscn")
# also need an individual torch pickup for when dropped, same for arrows
var drop_clone

func add_item_drop(itemID):
	#weapons
	if itemID == 1:
		drop_clone = sword_drop.instance()
	elif itemID == 2:
		drop_clone = lightning_sword_drop.instance()
	elif itemID == 3:
		drop_clone = axe_drop.instance()
	elif itemID == 4:
		drop_clone = ice_axe_drop.instance()
	elif itemID == 5:
		drop_clone = claymore_drop.instance()
	elif itemID == 6:
		drop_clone = fire_claymore_drop.instance()
	elif itemID == 7:
		drop_clone = warhammer_drop.instance()
	elif itemID == 8:
		drop_clone = earth_warhammer_drop.instance()
	elif itemID == 9:
		drop_clone = straight_bow_drop.instance()
	elif itemID == 10:
		drop_clone = recurve_bow_drop.instance()
	elif itemID == 11:
		drop_clone = arrow_drop.instance()
	#armour and shields
	elif itemID == 16:
		drop_clone = chainmail_drop.instance()
	elif itemID == 17:
		drop_clone = scalemail_drop.instance()
	elif itemID == 18:
		drop_clone = fullplate_drop.instance()
	elif itemID == 39:
		drop_clone = buckler_shield_drop.instance()
	elif itemID == 40:
		drop_clone = small_shield_drop.instance()
	elif itemID == 41:
		drop_clone = medium_shield_drop.instance()
	elif itemID == 42:
		drop_clone = tower_shield_drop.instance()
	#items
	elif itemID == 28:
		drop_clone = strength_potion_drop.instance()
	elif itemID == 29:
		drop_clone = speed_potion_drop.instance()
	elif itemID == 30:
		drop_clone = fortitude_potion_drop.instance()
	elif itemID == 32:
		drop_clone = health_potion_drop.instance()
	elif itemID == 34:
		drop_clone = mana_potion_drop.instance()
	elif itemID == 35:
		drop_clone = tea_drop.instance()
	elif itemID == 36:
		drop_clone = green_apple_drop.instance()
	elif itemID == 37:
		drop_clone = red_apple_drop.instance()
	elif itemID == 38:
		drop_clone = torch_drop.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(drop_clone)
	drop_clone.global_transform = self.global_transform

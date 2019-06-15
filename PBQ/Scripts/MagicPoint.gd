extends Spatial

var lightning_strike = preload("res://Scenes/MagicScenes/LightningStrike.tscn")
var lightning_orbs
var ice_spike = preload("res://Scenes/MagicScenes/IceSpike.tscn")
var ice_orbs
var fire_ball = preload("res://Scenes/MagicScenes/FireBall.tscn")
var fire_orbs
var earth_strike = preload("res://Scenes/MagicScenes/EarthStrike.tscn")
var earth_orbs

func lightning_attack_01():
	var clone = lightning_strike.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.lightning_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.lightning_01.magic_speed

func lightning_attack_02():
	var clone = lightning_orbs.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.lightning_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.lightning_01.magic_speed

func ice_attack_01():
	var clone = ice_spike.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.ice_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.ice_01.magic_speed

func ice_attack_02():
	var clone = ice_orbs.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.ice_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.ice_01.magic_speed

func fire_attack_01():
	var clone = fire_ball.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.fire_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.fire_01.magic_speed

func fire_attack_02():
	var clone = fire_orbs.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.fire_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.fire_01.magic_speed

func earth_attack_01():
	var clone = earth_strike.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.earth_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.earth_01.magic_speed

func earth_attack_02():
	var clone = earth_orbs.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.earth_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.earth_01.magic_speed
